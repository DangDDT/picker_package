// ignore_for_file: void_checks

import 'package:core_picker/src/presentation/camera/camera_handle_view.dart';
import 'package:core_picker/src/presentation/camera_preview/preview_binding.dart';
import 'package:core_picker/src/presentation/camera_preview/preview_view.dart';
import 'package:core_picker/src/presentation/picker_menu/picker_menu_binding.dart';
import 'package:core_picker/src/presentation/picker_menu/picker_menu_view.dart';
import 'package:get/get.dart';

import '../../src/presentation/camera/camera_handle_binding.dart';
import 'router_constant.dart';

class ModuleRouter {
  static final List<GetPage> routes = [
    //  GetPage<dynamic>(
    //   name: route_name,
    //   page: () => const PageName(),
    //   binding: BindingsBuilder(() {
    //     Get.lazyPut(() => PageNameCtrl());
    //     ...
    //   }),
    // ),
    GetPage(
      name: menuPickerRoute,
      page: () => const PickerMenuView(),
      binding: PickerMenuBinding(),
    ),

    GetPage(
      name: goCameraRoute,
      page: () => const CameraHandleView(),
      binding: CameraHandleBinding(),
      transitionDuration: const Duration(milliseconds: 210),
    ),

    GetPage(
      name: previewRoute,
      page: () => const PreviewView(),
      binding: PreviewBinding(),
      transitionDuration: const Duration(milliseconds: 210),
    ),
  ];
}
