import 'package:core_picker/src/presentation/location_picker/widgets/my_location_map.dart';
import 'package:core_picker/src/presentation/shared/fade_transition_wrapper.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:location/location.dart';
import 'package:lottie/lottie.dart';
import 'package:permission_handler/permission_handler.dart' as permission_handler;

import '../../../core/core.dart';
import '../../domain/domain.dart';
import '../picker_menu/widgets/picker_title.dart';
import '../shared/color_filter_wrapper.dart';
import '../shared/fade_scale_transition_wrapper.dart';
import 'location_picker_controller.dart';

class LocationPickerView extends GetView<LocationPickerController> {
  final ScrollController scrollController;
  const LocationPickerView({super.key, required this.scrollController});
  @override
  Widget build(BuildContext context) {
    controller.scrollController = scrollController;
    return Column(
      children: [
        _Header(),
        Expanded(child: _PemissionLocationGuard()),
      ],
    );
  }
}

class _Header extends GetView<LocationPickerController> {
  const _Header();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {},
      onVerticalDragUpdate: controller.onHeaderVerticalDragUpdate,
      onVerticalDragEnd: controller.onHeaderVerticalDragEnd,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const _CancelButton(),
            PickerTitle(title: AttachmentType.location.title),
            const _AdditionalAction(),
          ],
        ),
      ),
    );
  }
}

class _PemissionLocationGuard extends GetView<LocationPickerController> {
  const _PemissionLocationGuard();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      switch (controller.permissionStatus.value) {
        case PermissionStatus.denied:
          return const _LocationPermissions(
            isPermanent: true,
            onPressed: null,
          );
        case PermissionStatus.deniedForever:
          return const _LocationPermissions(
            isPermanent: true,
            onPressed: null,
          );
        case PermissionStatus.granted:
          return Stack(
            fit: StackFit.loose,
            children: [
              Positioned(
                child: FadeTransitionWrapper(
                  duration: const Duration(milliseconds: 410),
                  child: SizedBox(
                    height: Get.height * 0.3,
                    child: const MyLocationMap(),
                  ),
                ),
              ),
              Positioned.fill(
                child: Padding(
                  padding: EdgeInsets.only(top: Get.height * 0.3 - 20),
                  child: const _LocationFunctionListCard(),
                ),
              ),
            ],
          );
        default:
          return const _LocationPermissions(
            isPermanent: true,
            onPressed: null,
          );
      }
    });
  }
}

class _LocationFunctionListCard extends GetView<LocationPickerController> {
  const _LocationFunctionListCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      decoration: BoxDecoration(
        color: kTheme.colorScheme.surface,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      child: ListView.separated(
        controller: controller.scrollController,
        shrinkWrap: true,
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
        itemBuilder: (context, index) => FadeScaleTransitionWrapper(
          child: _LocationFunctionItem(
            itemObs: controller.cardFunctionViewModels[index],
          ),
        ),
        separatorBuilder: (context, index) => const SizedBox(height: 12),
        itemCount: controller.cardFunctionViewModels.length,
      ),
    );
  }
}

class _LocationFunctionItem extends GetView<LocationPickerController> {
  final Rx<CardFunctionViewModel> itemObs;
  const _LocationFunctionItem({required this.itemObs});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final item = itemObs.value;
      return Card(
        elevation: 0.1,
        child: ListTile(
          leading: item.icon,
          title: Text(item.title, style: kTheme.textTheme.titleMedium),
          subtitle: Text(item.subTitle, style: kTheme.textTheme.titleSmall?.copyWith(color: kTheme.disabledColor)),
          trailing: Builder(builder: (_) {
            switch (item.state) {
              case LoadingState.initial:
                return SizedBox(
                  height: 20,
                  width: 20,
                  child: Icon(Icons.arrow_forward_ios, size: 16, color: kTheme.colorScheme.primary),
                );
              case LoadingState.loading:
                return const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                  ),
                );
              case LoadingState.success:
                return SizedBox(
                  width: 30,
                  height: 30,
                  child: ColorFilteredWrapper(
                    child: Lottie.asset(
                      Assets.core_picker$assets_icons_94217_check_right_json,
                      fit: BoxFit.cover,
                      repeat: false,
                    ),
                  ),
                );
              case LoadingState.error:
                return const Icon(Icons.error, color: Colors.red);
              default:
                return const Icon(Icons.error, color: Colors.red);
            }
          }),
          onTap: () => controller.onTapCardFunction(item),
        ),
      );
    });
  }
}

class _CancelButton extends GetView<LocationPickerController> {
  const _CancelButton();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => controller.onBack(),
      child: Text(
        LanguageKeys.cancel.tr,
        style: kTheme.textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.w500,
          color: kTheme.disabledColor,
        ),
      ),
    );
  }
}

class _LocationPermissions extends StatelessWidget {
  final bool isPermanent;
  final VoidCallback? onPressed;

  const _LocationPermissions({
    Key? key,
    required this.isPermanent,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.only(
              left: 16.0,
              top: 30.0,
              right: 16.0,
            ),
            child: Text(
              'Cần quyền truy cập vị trí',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          Container(
            padding: const EdgeInsets.only(
              left: 16.0,
              top: 24.0,
              right: 16.0,
            ),
            child: Text(
              'Chúng tôi cần quyền truy cập vào vị trí của bạn. ${isPermanent ? 'Bạn cần mở cài đặt và cấp quyền truy cập thư viện cho ứng dụng.' : ''}',
              textAlign: TextAlign.center,
            ),
          ),
          Container(
            padding: const EdgeInsets.only(left: 16.0, top: 24.0, right: 16.0, bottom: 24.0),
            child: ElevatedButton(
              child: Text(isPermanent ? 'Mở cài đặt' : 'Cho phép truy cập'),
              onPressed: () => isPermanent ? permission_handler.openAppSettings() : onPressed?.call(),
            ),
          ),
        ],
      ),
    );
  }
}

class _AdditionalAction extends GetView<LocationPickerController> {
  const _AdditionalAction();

  @override
  Widget build(BuildContext context) {
    return const SizedBox(width: 35);
  }
}
