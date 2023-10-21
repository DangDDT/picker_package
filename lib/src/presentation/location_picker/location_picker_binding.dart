import 'package:get/get.dart';

import 'location_picker_controller.dart';

class LocationPickerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LocationPickerController>(
      () => LocationPickerController(),
    );
  }
}
