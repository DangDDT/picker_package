import 'package:core_picker/src/presentation/shared/color_filter_wrapper.dart';
import 'package:core_picker/src/presentation/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../core/core.dart';
import '../picker_menu/widgets/picker_title.dart';
import 'file_picker_controller.dart';

class FilePickerView extends GetView<FilePickerController> {
  final ScrollController scrollController;
  const FilePickerView({super.key, required this.scrollController});
  @override
  Widget build(BuildContext context) {
    controller.scrollController = scrollController;
    return Column(
      children: const [
        _Header(),
        Expanded(
          child: _ListFilePickerFunction(),
        ),
      ],
    );
  }
}

class _Header extends GetView<FilePickerController> {
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
            PickerTitle(title: AttachmentType.file.title),
            const _AdditionalAction(),
          ],
        ),
      ),
    );
  }
}

class _CancelButton extends GetView<FilePickerController> {
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

class _AdditionalAction extends GetView<FilePickerController> {
  const _AdditionalAction();

  @override
  Widget build(BuildContext context) {
    return const SizedBox(width: 35);
  }
}

class _ListFilePickerFunction extends GetView<FilePickerController> {
  const _ListFilePickerFunction();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.only(bottom: 12),
      controller: controller.scrollController,
      shrinkWrap: true,
      itemCount: controller.listFunctionFilePicker.length,
      itemBuilder: (context, index) {
        final item = controller.listFunctionFilePicker[index];
        return FadeThroughTransitionWrapper(
          child: _FilePickerFunctionItem(item: item),
        );
      },
    );
  }
}

class _FilePickerFunctionItem extends StatelessWidget {
  const _FilePickerFunctionItem({
    required this.item,
  });

  final FilePickerFunctionViewModel item;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: GestureDetector(
        onTap: item.onTap.call,
        child: Card(
          elevation: 0.2,
          child: ListTile(
            horizontalTitleGap: 4,
            minLeadingWidth: 0,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            leading: SizedBox(
              width: 60,
              height: 60,
              child: Center(
                child: FadeSlideTransition(
                  duration: const Duration(milliseconds: 410),
                  child: ColorFilteredWrapper(
                    child: item.icon,
                  ),
                ),
              ),
            ),
            title: Text(item.title, style: kTheme.textTheme.titleMedium),
            subtitle: Text(
              item.subtitle,
              style: kTheme.textTheme.bodySmall!
                  .copyWith(color: kTheme.disabledColor),
            ),
          ),
        ),
      ),
    );
  }
}

class _PermissionsDenied extends StatelessWidget {
  final bool isPermanent;
  final VoidCallback? onPressed;

  const _PermissionsDenied({
    Key? key,
    required this.isPermanent,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.only(
            left: 16.0,
            top: 24.0,
            right: 16.0,
          ),
          child: Text(
            'Cần quyền truy cập bộ nhớ',
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
            'Chúng tôi cần quyền truy cập vào bộ nhớ của bạn. ${isPermanent ? 'Bạn cần mở cài đặt và cấp quyền truy cập bộ nhớ cho ứng dụng.' : ''}',
            textAlign: TextAlign.center,
          ),
        ),
        Container(
          padding: const EdgeInsets.only(
              left: 16.0, top: 24.0, right: 16.0, bottom: 24.0),
          child: ElevatedButton(
            child: Text(isPermanent ? 'Mở cài đặt' : 'Cho phép truy cập'),
            onPressed: () =>
                isPermanent ? openAppSettings() : onPressed?.call(),
          ),
        ),
      ],
    );
  }
}
