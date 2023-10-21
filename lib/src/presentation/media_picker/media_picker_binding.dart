import 'package:get/get.dart';

import 'media_picker_controller.dart';

class MediaPickerBinding extends Bindings {
  MediaPickerBinding();
  @override
  void dependencies() {
    Get.lazyPut<MediaPickerController>(() => MediaPickerController());
  }
}
