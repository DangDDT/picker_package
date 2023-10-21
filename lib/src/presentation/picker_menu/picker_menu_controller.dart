import 'dart:async';

import 'package:core_picker/core/core.dart';
import 'package:core_picker/src/domain/enums/private/picker_tab_status.dart';
import 'package:core_picker/src/presentation/picker_menu/picker_menu_view.dart';
import 'package:core_picker/src/presentation/picker_menu/widgets/cancel_confirm_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../infrastructure/mappers/tab_picker_mapper.dart';
import 'picker_menu_view_model.dart';

class PickerMenuController extends GetxController
    with GetTickerProviderStateMixin {
  ///Config
  late final ModuleConfig _config = Get.find(tag: CorePicker.packageName);
  ModuleConfig get config => _config;

  ///ViewModel
  late final PickerMenuViewModel _pickerMenuModel;
  PickerMenuViewModel get pickerMenuModel => _pickerMenuModel;

  ///Constants
  static const List<AttachmentType> _attachmentAllowSearchFunction = [
    AttachmentType.media,
  ];

  static const List<AttachmentType> _returnIndependence = [
    AttachmentType.location,
  ];
  get attachmentAllowSearchFunction => _attachmentAllowSearchFunction;

  ///Controller
  late final TabController tabController;
  late final AnimationController animationController;
  ScrollController? scrollController;
  late DraggableScrollableController dragScrollController;
  late FocusNode captionFocusNode;

  //Mapper
  final TabPickerMapper _tabPickerMapper =
      Get.find(tag: CorePicker.packageName);

  @override
  void onInit() {
    _pickerMenuModel = PickerMenuViewModel()
      ..setTabs = [
        TabViewModel.selected(attachmentType: _config.categories.first),
        ..._config.categories.sublist(1).map(
              (e) => TabViewModel(
                attachmentType: e,
                controller: _tabPickerMapper.getTabPickerControllerFromType(e),
              ),
            )
      ].toList()
      ..setSelectedTab =
          TabViewModel.selected(attachmentType: _config.categories.first)
      ..setSelectedAttachment = _tabPickerMapper
          .getTabPickerControllerFromType(_config.categories.first)
          .selectedResult;
    _initController();
    _initListener();
    super.onInit();
  }

  _initController() {
    dragScrollController = DraggableScrollableController();
    tabController = TabController(
      length: _pickerMenuModel.tabs.length,
      vsync: this,
      animationDuration: const Duration(milliseconds: 300),
    )..addListener(
        () async {
          if (tabController.indexIsChanging) {
            _pickerMenuModel.setSelectedTab = TabViewModel.selected(
                attachmentType:
                    pickerMenuModel.tabs[tabController.index].attachmentType);
            await Future.delayed(
              const Duration(milliseconds: 60),
              () async {
                final isScrollDown = dragScrollController.size >
                    kDraggableScrollableSheetInitialChildSize;

                if (isScrollDown) {
                  await dragScrollController.animateTo(
                    kDraggableScrollableSheetInitialChildSize - 0.01,
                    duration: const Duration(milliseconds: 210),
                    curve: Curves.easeInOut,
                  );
                  await dragScrollController.animateTo(
                    kDraggableScrollableSheetInitialChildSize,
                    duration: const Duration(milliseconds: 110),
                    curve: Curves.easeInOut,
                  );
                } else {
                  await dragScrollController.animateTo(
                    kDraggableScrollableSheetInitialChildSize + 0.01,
                    duration: const Duration(milliseconds: 110),
                    curve: Curves.easeInOut,
                  );
                  await dragScrollController.animateTo(
                    kDraggableScrollableSheetInitialChildSize,
                    duration: const Duration(milliseconds: 210),
                    curve: Curves.easeInOut,
                  );
                }
              },
            );
          }
        },
      );
    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
  }

  _initListener() {
    _onTabChangeListener();
    _onSelectedResultChangedListener();
    _onCaptionFocusListener();
  }

  _onTabChangeListener() {
    ever(
      _pickerMenuModel.selectedTab,
      (tab) async {
        _tabPickerMapper.getTabPickerControllerFromType(tab.attachmentType);
      },
    );
  }

  _onCaptionFocusListener() {
    captionFocusNode = FocusNode()
      ..addListener(
        () async {
          if (captionFocusNode.hasFocus) {
            await dragScrollController.animateTo(
              kDraggableScrollableSheetMaxChildSize,
              duration: const Duration(milliseconds: 210),
              curve: Curves.easeInOut,
            );
          }
        },
      );
  }

  _onSelectedResultChangedListener() {
    for (final attachmentType
        in config.categories.where((e) => !_returnIndependence.contains(e))) {
      ever(
        _tabPickerMapper
            .getTabPickerControllerFromType(attachmentType)
            .selectedResult,
        (value) {
          _pickerMenuModel.selectedAttachment.call(value);
          if (value.isNotEmpty) {
            _pickerMenuModel.setStatus = PickerTabStatus.readyToSubmit;
          } else {
            _pickerMenuModel.setStatus = PickerTabStatus.empty;
          }
        },
      );
    }
  }

  void onClearSelected() {
    _tabPickerMapper
        .getTabPickerControllerFromType(
            pickerMenuModel.selectedTab.value.attachmentType)
        .onClearSelectedResult();
  }

  onChangeCaption(String caption) {
    _pickerMenuModel.setCaption = caption;
  }

  Future<void> onSubmit() async {
    final attachmentType = _pickerMenuModel.selectedTab.value.attachmentType;
    final datas = await _tabPickerMapper.onSubmitFromType(attachmentType);
    final result = AttachmentResult(
      type: attachmentType,
      caption: _pickerMenuModel.caption.value,
      data: datas,
      itemCount: datas.length,
      selectedTime: DateTime.now(),
    );
    Get.back(result: result);
  }

  Future<bool> onCloseTab() async {
    if (_pickerMenuModel.status.value == PickerTabStatus.empty) {
      return true;
    }
    final isPop = await Get.dialog<bool?>(const CancelConfirmDialog());
    return isPop ?? false;
  }

  bool get isShowCaptionField {
    switch (pickerMenuModel.selectedTab.value.attachmentType) {
      case AttachmentType.media:
        return _config.mediaPickerOption?.isUseCaptionField ?? false;
      case AttachmentType.file:
        return _config.filePickerOption?.isUseCaptionField ?? false;
      case AttachmentType.location:
        return _config.locationPickerOption?.isUseCaptionField ?? false;
    }
  }

  String get captionHint {
    switch (pickerMenuModel.selectedTab.value.attachmentType) {
      case AttachmentType.media:
        return _config.mediaPickerOption?.captionFieldConfig.captionHint ??
            DefaultPickerConstants.defaultCaption;
      case AttachmentType.file:
        return _config.filePickerOption?.captionFieldConfig.captionHint ??
            DefaultPickerConstants.defaultCaption;
      case AttachmentType.location:
        return _config.locationPickerOption?.captionFieldConfig.captionHint ??
            DefaultPickerConstants.defaultCaption;
    }
  }

  String get countUnit {
    switch (pickerMenuModel.selectedTab.value.attachmentType) {
      case AttachmentType.media:
        return LanguageKeys.image_s.tr.toLowerCase();
      case AttachmentType.file:
        return LanguageKeys.file_s.tr.toLowerCase();
      case AttachmentType.location:
        return LanguageKeys.location_s.tr.toLowerCase();
    }
  }

  void onHeaderVerticalDragUpdate(DragUpdateDetails details) async {
    double sizeTo = dragScrollController.size - (details.delta.dy / Get.height);
    dragScrollController.jumpTo(sizeTo);
  }

  Future<void> onHeaderVerticalDragEnd(DragEndDetails details) async {
    double sizeTo = dragScrollController.size;
    final isScrollDown = details.velocity.pixelsPerSecond.dy > 0;
    final isBetweenInitAndMax =
        sizeTo > kDraggableScrollableSheetInitialChildSize &&
            sizeTo < kDraggableScrollableSheetMaxChildSize;
    final isBetweenMinAndInit =
        sizeTo > kDraggableScrollableSheetMinChildSize &&
            sizeTo < kDraggableScrollableSheetInitialChildSize;
    final isMoreThanMax = sizeTo > kDraggableScrollableSheetMaxChildSize;
    if (isScrollDown) {
      if (isBetweenInitAndMax) {
        sizeTo = kDraggableScrollableSheetInitialChildSize;
      } else if (isBetweenMinAndInit) {
        sizeTo = kDraggableScrollableSheetMinChildSize + 0.01;
      } else if (isMoreThanMax) {
        sizeTo = kDraggableScrollableSheetMaxChildSize;
      }
    } else {
      if (isBetweenInitAndMax) {
        sizeTo = kDraggableScrollableSheetMaxChildSize;
      } else if (isBetweenMinAndInit) {
        sizeTo = kDraggableScrollableSheetInitialChildSize;
      } else if (isMoreThanMax) {
        sizeTo = kDraggableScrollableSheetMaxChildSize;
      }
    }
    await dragScrollController.animateTo(
      sizeTo,
      duration: const Duration(milliseconds: 160),
      curve: Curves.decelerate,
    );
  }
}
