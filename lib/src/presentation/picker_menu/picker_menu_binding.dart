import 'package:get/get.dart';

import 'picker_menu_controller.dart';

class PickerMenuBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<PickerMenuController>(PickerMenuController());
  }

  Future<void> dispose() async {
    await Get.delete<PickerMenuController>();
  }
}
