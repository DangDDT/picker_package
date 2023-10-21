import 'package:get/get.dart';

import 'camera_handle_controller.dart';

class CameraHandleBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CameraHandleController>(() => CameraHandleController());
  }
}
