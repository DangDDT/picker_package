import 'package:core_picker/src/presentation/file_picker/file_picker_controller.dart';
import 'package:core_picker/src/presentation/media_picker/media_picker_binding.dart';
import 'package:get/get.dart';

import '../../../../core/core.dart';
import '../../domain/mappers/tab_picker_mapper/base_tab_picker_mapper.dart';
import '../../presentation/@base/tab_picker_controller.dart';
import '../../presentation/file_picker/file_picker_binding.dart';
import '../../presentation/media_picker/media_picker_controller.dart';
import '../../presentation/location_picker/location_picker_binding.dart';
import '../../presentation/location_picker/location_picker_controller.dart';

class TabPickerMapper extends BaseTabPickerMapper {
  void initMapperByCategory(List<AttachmentType> attachmentTypes) {
    for (var element in attachmentTypes) {
      switch (element) {
        case AttachmentType.media:
          MediaPickerBinding().dependencies();
          break;
        case AttachmentType.file:
          FilePickerBinding().dependencies();
          break;
        case AttachmentType.location:
          LocationPickerBinding().dependencies();
          break;
      }
    }
  }

  @override
  Future<List<AttachmentData>> onSubmitFromType(
      AttachmentType attachmentType) async {
    final TabPickerController tabPickerController =
        getTabPickerControllerFromType(attachmentType);
    final List<AttachmentData> attachmentData =
        await tabPickerController.onSubmit();
    return attachmentData;
  }

  @override
  TabPickerController getTabPickerControllerFromType(
      AttachmentType attachmentType) {
    switch (attachmentType) {
      case AttachmentType.media:
        return Get.find<MediaPickerController>();
      case AttachmentType.file:
        return Get.find<FilePickerController>();
      case AttachmentType.location:
        return Get.find<LocationPickerController>();
    }
  }

  @override
  void onCloseTab(AttachmentType attachmentType) {
    final TabPickerController tabPickerController =
        getTabPickerControllerFromType(attachmentType);
    tabPickerController.onCloseTab();
  }

  @override
  RxList<AttachmentData> getSelectedAttachmentData(
      AttachmentType attachmentType) {
    final TabPickerController tabPickerController =
        getTabPickerControllerFromType(attachmentType);
    final result = tabPickerController.selectedResult;
    return result;
  }

  @override
  void disposeControllers() {
    Get.delete<MediaPickerController>();
    Get.delete<FilePickerController>();
    Get.delete<LocationPickerController>();
  }
}
