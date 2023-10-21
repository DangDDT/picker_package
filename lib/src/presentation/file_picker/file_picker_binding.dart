import 'package:get/get.dart';

import 'file_picker_controller.dart';

class FilePickerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FilePickerController>(() => FilePickerController());
  }
}
