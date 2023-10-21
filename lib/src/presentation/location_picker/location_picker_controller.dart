import 'package:core_picker/src/domain/models/attachment_data.dart';
import 'package:core_picker/src/presentation/@base/tab_picker_controller.dart';
import 'package:core_picker/src/presentation/location_picker/widgets/location_submit_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:location/location.dart';
import 'package:lottie/lottie.dart';

import '../../../core/core.dart';
import '../../domain/domain.dart';
import '../../domain/models/location_return_value.dart';
import '../picker_menu/picker_menu_controller.dart';
import '../picker_menu/widgets/cancel_confirm_dialog.dart';

class LocationPickerController extends GetxController with WidgetsBindingObserver implements TabPickerController {
  final Rxn<LocationData> _myLocationData = Rxn<LocationData>();
  Rxn<LocationData> get myLocationData => _myLocationData;

  @override
  AttachmentType get attachmentType => AttachmentType.location;

  @override
  Future<List<AttachmentData>> onSubmit() {
    return Future.value(selectedResult);
  }

  final ModuleConfig _config = Get.find<ModuleConfig>(tag: CorePicker.packageName);
  ModuleConfig get config => _config;

  final List<Rx<CardFunctionViewModel>> _cardFunctionViewModels = [
    CardFunctionViewModel.findLocation().obs,
  ];
  List<Rx<CardFunctionViewModel>> get cardFunctionViewModels => _cardFunctionViewModels;

  final Rx<PermissionStatus> _permissionStatus = Rx<PermissionStatus>(PermissionStatus.denied);
  Rx<PermissionStatus> get permissionStatus => _permissionStatus;

  final Rxn<String> _caption = Rxn<String>();
  Rxn<String> get caption => _caption;

  @override
  void onInit() {
    requestPermission();
    super.onInit();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      requestPermission();
    }
    super.didChangeAppLifecycleState(state);
  }

  @override
  void onCloseTab() {
    return;
  }

  Future<void> requestPermission() async {
    Location locationClient = Location();
    PermissionStatus permissionGranted = await locationClient.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await locationClient.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        _permissionStatus.call(PermissionStatus.denied);
        return;
      }
    }
    _permissionStatus.call(permissionGranted);
    final myLocation = await locationClient.getLocation();
    _myLocationData.call(myLocation);
    Logger.logInfo(permissionGranted.toString(), name: 'LocationPickerController|requestPermission');
  }

  void onChangeCaption(String? value) {
    _caption.call(value);
  }

  Future<void> onTapCardFunction(CardFunctionViewModel card) async {
    switch (card.type) {
      case LocationPickerType.findMyLocation:
        await _getLocation();
        break;
      default:
    }
  }

  Future<void> _getLocation() async {
    const LocationPickerType type = LocationPickerType.findMyLocation;
    _cardFunctionViewModels.firstWhere((e) => e.value.type.isFindMyLocation).update((val) {
      val?.state = LoadingState.loading;
    });

    try {
      Future.delayed(const Duration(milliseconds: 410), () async {
        _cardFunctionViewModels.firstWhere((e) => e.value.type.isFindMyLocation).update((val) {
          val?.state = LoadingState.success;
        });
      });
      Logger.logOK(selectedResult.toString(), name: 'LocationPickerController|_getLocation');
      Future.delayed(const Duration(milliseconds: 2200), () async {
        await _showDialogAndSubmit(type);
      });
    } catch (e, stackTrace) {
      _cardFunctionViewModels.firstWhere((e) => e.value.type.isFindMyLocation).update((val) {
        val?.state = LoadingState.error;
      });
      Logger.log(e.toString(), name: 'LocationPickerController|_getLocation', stackTrace: stackTrace);
    }
  }

  /// Hiển thị LocationSubmitDialog và LocationReturnValue sau đó map về LocationAttachmentData trả về cho root caller.
  Future<void> _showDialogAndSubmit(LocationPickerType type) async {
    switch (type) {
      case LocationPickerType.findMyLocation:

        ///Nếu config.isUseCaptionField == true thì hiển thị dialog nhập caption.
        if (config.locationPickerOption?.isUseCaptionField ?? false) {
          final result = await Get.dialog<LocationReturnValue?>(
            const LocationSubmitDialog(),
            barrierDismissible: false,
          );
          _cardFunctionViewModels.firstWhere((e) => e.value.type.isFindMyLocation).update((val) {
            val?.state = LoadingState.initial;
          });
          if (result?.isBackToRoot == false) {
            return;
          }
        }
        final attachmentData = LocationAttachmentData(
          _myLocationData.value?.latitude,
          _myLocationData.value?.longitude,
          LocationPickerType.findMyLocation.tag,
        );

        final attachmentResult = AttachmentResult(
          type: AttachmentType.location,
          data: [attachmentData],
          caption: _caption.value,
          itemCount: [attachmentData].length,
          selectedTime: DateTime.now(),
        );
        Get.back(result: attachmentResult);
        break;
      default:
        return;
    }
  }

  @override
  Future<void> onBack() async {
    if (selectedResult.isEmpty) {
      Get.back();
      return;
    }
    final isPop = await Get.dialog<bool?>(const CancelConfirmDialog());
    if (isPop == true) {
      Get.back();
    }
  }

  @override
  void onHeaderVerticalDragUpdate(DragUpdateDetails details) =>
      Get.find<PickerMenuController>().onHeaderVerticalDragUpdate.call(details);

  @override
  Future<void> onHeaderVerticalDragEnd(DragEndDetails details) async {
    if (isClosed) return;
    final pickerMenuController = Get.find<PickerMenuController>();
    pickerMenuController.onHeaderVerticalDragEnd.call(details);
  }

  ///Chưa hoặc không cần sử dụng những property này.
  @override
  ScrollController? scrollController;

  @override
  RxList<AttachmentData> selectedResult = RxList<AttachmentData>();

  @override
  Future<void> onClearSelectedResult() async {
    return;
  }
}

class CardFunctionViewModel {
  final String title;
  final String subTitle;
  final String description;
  final Widget icon;
  final LocationPickerType type;
  LoadingState state;

  CardFunctionViewModel({
    required this.title,
    required this.subTitle,
    required this.description,
    required this.icon,
    required this.type,
    this.state = LoadingState.initial,
  });

  factory CardFunctionViewModel.findLocation() => CardFunctionViewModel(
        title: LanguageKeys.myLocation.tr,
        subTitle: LanguageKeys.myLocationSubtitle.trParams({'number': '40'}),
        description: 'Chức năng này sẽ giúp bạn tìm vị trí hiện tại của mình.',
        icon: Lottie.asset(
          Assets.core_picker$assets_icons_93832_location_icon_json,
          filterQuality: FilterQuality.high,
        ),
        type: LocationPickerType.findMyLocation,
      );
}

enum LocationPickerType {
  findMyLocation;

  String get tag {
    switch (this) {
      case LocationPickerType.findMyLocation:
        return 'findMyLocation';
      default:
        return '';
    }
  }

  bool get isFindMyLocation => this == LocationPickerType.findMyLocation;
}
