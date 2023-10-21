import 'package:core_picker/core/core.dart';
import 'package:core_picker/src/infrastructure/mappers/tab_picker_mapper.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class GlobalBinding {
  static void setUpLocator({
    required bool enableLog,
    String? submitButtonTitle,
    required IconData submitButtonIcon,
    MediaPickerOption? mediaPickerOption,
    LocationPickerOption? locationPickerOption,
    FilePickerOption? filePickerOption,
    List<AttachmentType>? categories,
  }) {
    Get.put(
      ModuleConfig(
        submitButtonTitle: submitButtonTitle,
        submitButtonIcon: submitButtonIcon,
        isShowLog: enableLog,
        categories: categories ?? [],
        mediaPickerOption: mediaPickerOption,
        locationPickerOption: locationPickerOption,
        filePickerOption: filePickerOption,
      ),
      tag: CorePicker.packageName,
    );

    final tabPickerMapper = Get.put<TabPickerMapper>(TabPickerMapper(),
        permanent: true, tag: CorePicker.packageName);
    tabPickerMapper.initMapperByCategory(categories ?? []);
  }

  static Future<void> dispose() async {
    final TabPickerMapper tabPickerMapper =
        Get.find<TabPickerMapper>(tag: CorePicker.packageName);
    tabPickerMapper.disposeControllers();
    await Get.delete<ModuleConfig>(tag: CorePicker.packageName);
  }
}
