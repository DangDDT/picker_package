// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vif_previewer/previewer.dart';

import '../../../core/core.dart';
import '../../domain/domain.dart';
import '../picker_menu/widgets/cancel_confirm_dialog.dart';

class PreviewController extends GetxController {
  ///Params
  final bool _isPaging = Get.arguments['isPaging'] ?? false;
  final int _initialIndex = Get.arguments['initialIndex'] ?? 0;

  final bool _isShowSubmitBar = Get.arguments['isShowSubmitBar'] ?? false;
  bool get isShowSubmitBar => _isShowSubmitBar;

  final ScrollPhysics? _physic = Get.arguments['physic'];
  ScrollPhysics? get physic => _physic;

  final List<MediaPreviewData> _data = Get.arguments['data'] ?? [];
  final MediaPagingConfig? _pagingConfig = Get.arguments['pagingConfig'];
  final Function(int, MediaPreviewData<dynamic>)? _onScrollToItem =
      Get.arguments['onScrollToItem'];

  // /Config
  final ModuleConfig _config =
      Get.find<ModuleConfig>(tag: CorePicker.packageName);
  ModuleConfig get config => _config;

  bool get isShowPreviewInfo =>
      config.mediaPickerOption?.isShowPreviewInfo ?? false;

  final Rxn<String> _caption = Rxn<String>();
  Rxn<String> get caption => _caption;

  late final MediaPreviewController _mediaPreviewController;
  MediaPreviewController get mediaPreviewController => _mediaPreviewController;

  @override
  void onInit() {
    _mediaPreviewController = _isPaging
        ? MediaPreviewController.paging(
            initialMediaList: _data,
            pagingConfig: _pagingConfig!,
            onScrollToItem: _onScrollToItem,
            initialIndex: _initialIndex,
          )
        : MediaPreviewController(data: _data);
    super.onInit();
  }

  void onChangeCaption(String? value) {
    _caption.call(value);
  }

  ///if isShowSubmitBar = true
  void onSubmit() {
    Get.back(
      result: PreviewReturnValue(
        caption: caption.value,
      ),
    );
  }

  @override
  void onClose() {
    FocusManager.instance.primaryFocus?.unfocus();
    super.onClose();
  }

  Future<bool> onBack() async {
    if (caption.value == null || caption.value!.isEmpty) {
      return true;
    }
    final isPop = await Get.dialog<bool?>(const CancelConfirmDialog());
    return isPop ?? false;
  }
}
