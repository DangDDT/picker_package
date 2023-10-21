import 'dart:typed_data';

import 'package:core_picker/src/domain/enums/private/image_section.dart';
import 'package:core_picker/src/domain/enums/private/loading_enum.dart';
import 'package:core_picker/src/presentation/camera_thumbnail/camera_thumbnail_view.dart';
import 'package:core_picker/src/presentation/shared/fade_transition_wrapper.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../core/core.dart';
import '../picker_menu/widgets/picker_title.dart';
import '../shared/shared.dart';
import '../view_models/state_data_view_model.dart';
import 'media_picker_view_model.dart';
import 'media_picker_controller.dart';

const double _kBottomPaddingVarianceForListImage = 100;

class MediaPickerView extends GetView<MediaPickerController> {
  final ScrollController scrollController;
  const MediaPickerView({
    required this.scrollController,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    controller.scrollController = scrollController
      ..addListener(() {
        if (scrollController.position.pixels >=
            scrollController.position.maxScrollExtent * .75) {
          controller.nextPage();
        }
      });
    return SizedBox(
      width: Get.width,
      height: Get.height,
      child: Column(
        children: [
          const _Header(),
          _PermissionImageGuard(),
        ],
      ),
    );
  }
}

class _Header extends GetView<MediaPickerController> {
  const _Header();

  @override
  Widget build(BuildContext context) {
    // ignore: avoid_unnecessary_containers
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {},
      onVerticalDragUpdate: controller.onHeaderVerticalDragUpdate,
      onVerticalDragEnd: controller.onHeaderVerticalDragEnd,
      // ignore: avoid_unnecessary_containers
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const _CancelButton(),
            PickerTitle(title: AttachmentType.media.title),
            const _AdditionalAction(),
          ],
        ),
      ),
    );
  }
}

class _AdditionalAction extends StatelessWidget {
  const _AdditionalAction();

  @override
  Widget build(BuildContext context) {
    return const SizedBox(width: 35);
  }
}

class _CancelButton extends GetView<MediaPickerController> {
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

class _PermissionImageGuard extends GetView<MediaPickerController> {
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      switch (controller.imageModel.mediaSection.value) {
        case MediaSection.noStoragePermission:
          return _ImagePermissions(
            isPermanent: false,
            onPressed: controller.requestFilePermission,
          );
        case MediaSection.noStoragePermissionPermanent:
          return _ImagePermissions(
            isPermanent: true,
            onPressed: controller.requestFilePermission,
          );
        case MediaSection.browseFiles:
          return const _BrowseFiles();
        default:
          return const _ErrorWidget(callback: null);
      }
    });
  }
}

class _BrowseFiles extends GetView<MediaPickerController> {
  const _BrowseFiles();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      switch (controller.imageModel.listAssetEntityState.value.state) {
        dataNull:
        case LoadingState.initial:
        case LoadingState.loading:
          return Padding(
            padding: EdgeInsets.symmetric(vertical: Get.height * 0.1),
            child: const LoadingWidget(),
          );
        case LoadingState.error:
          return const _BrowseFileErrorWidget(
              message: "Lỗi tải ảnh, vui lòng thử lại");
        case LoadingState.success:
          if (controller.imageModel.listAssetEntityState.value.data == null) {
            continue dataNull;
          }
          return const _ImageGrid();
        case LoadingState.empty:
          return const _BrowseFileErrorWidget(
            message: "Hiện không có ảnh trong thư viện",
          );
      }
    });
  }
}

class _BrowseFileErrorWidget extends GetView<MediaPickerController> {
  final String message;
  const _BrowseFileErrorWidget({required this.message});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        controller: controller.scrollController,
        child: Builder(
          builder: (_) {
            if (controller.config.mediaPickerOption?.isUseCamera ?? false) {
              return Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 2),
                    child: SizedBox(
                      width: Get.width * .6,
                      height: 230,
                      child: const ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        child: _CameraArea(),
                      ),
                    ),
                  ),
                  kGapH12,
                  _ErrorWidget(
                    callback: controller.fetchItems,
                    message: message,
                  ),
                ],
              );
            } else {
              return _ErrorWidget(
                callback: controller.fetchItems,
                message: message,
              );
            }
          },
        ),
      ),
    );
  }
}

class _ImageGrid extends GetView<MediaPickerController> {
  const _ImageGrid();

  @override
  Widget build(BuildContext context) {
    return Expanded(child: Obx(() {
      return MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: Scrollbar(
          radius: const Radius.circular(10.0),
          thickness: 5.0,
          controller: controller.scrollController,
          child: GridView.builder(
            addAutomaticKeepAlives: true,
            controller: controller.scrollController,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount:
                  controller.config.mediaPickerOption?.mediaPerRow ??
                      DefaultPickerConstants.defaultImagePerRow,
              mainAxisSpacing: 2.0,
              crossAxisSpacing: 2.0,
            ),
            padding: EdgeInsets.only(
                bottom: Get.mediaQuery.padding.bottom +
                    _kBottomPaddingVarianceForListImage),
            shrinkWrap: true,
            cacheExtent: 1000,
            itemBuilder: (context, index) {
              if (controller.config.mediaPickerOption?.isUseCamera ?? false) {
                if (index == 0) {
                  return const _CameraArea();
                }
              }
              final imageIndex = index -
                  (controller.config.mediaPickerOption?.isUseCamera ?? false
                      ? 1
                      : 0);
              final assetEntityResult = controller
                  .imageModel.listAssetEntityState.value.data![imageIndex];
              return _ImageBuilder(
                  assetEntityResult: assetEntityResult, index: imageIndex);
            },
            itemCount:
                controller.imageModel.listAssetEntityState.value.data!.length +
                    (controller.config.mediaPickerOption?.isUseCamera ?? false
                        ? 1
                        : 0),
          ),
        ),
      );
    }));
  }
}

class _CameraArea extends GetView<MediaPickerController> {
  const _CameraArea();

  @override
  Widget build(BuildContext context) {
    final isUseCameraInside =
        controller.config.mediaPickerOption?.isUseCameraInsideAlbum ?? false;
    return GestureDetector(
      onTap: controller.onPickCamera,
      behavior: HitTestBehavior.opaque,
      child: !isUseCameraInside
          ? Container(
              color: Colors.grey[200],
              child: const Center(
                child: Icon(Icons.camera_alt),
              ),
            )
          : const CameraThumnailView(),
    );
  }
}

class _ImageBuilder extends GetView<MediaPickerController> {
  final Rx<StateDataVM<AssetEntityResult?>> assetEntityResult;
  final int index;
  const _ImageBuilder(
      {Key? key, required this.assetEntityResult, required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      switch (assetEntityResult.value.state) {
        case LoadingState.initial:
        case LoadingState.loading:
          return const _ImageItemWrapper(child: LoadingWidget());
        case LoadingState.error:
          return const _ImageItemWrapper(child: SizedBox());
        case LoadingState.success:
          final item = assetEntityResult.value.data!;
          return Hero(
            tag: ValueKey(item.assetEntity?.id),
            child: GestureDetector(
              onTap: () => controller.onImageDoubleTap(item, index),
              onLongPress: () => controller.onImageDoubleTap(item, index),
              child: AnimatedScale(
                duration: const Duration(milliseconds: 110),
                scale: controller.isDoubleTap.value == index ? 0.9 : 1.0,
                curve: Curves.linear,
                child: _ImageItem(
                  assetEntityResult: item,
                  isLongPressed: false,
                  isSelected:
                      controller.imageModel.selectedAssetEntity.contains(item),
                  isDoubleTap: controller.isDoubleTap.value == index,
                  isActive: controller.imageModel.selectedAssetEntity.isEmpty ||
                      controller.isMultiSelection ||
                      (!controller.isMultiSelection &&
                          controller
                              .imageModel.selectedAssetEntity.isNotEmpty &&
                          controller.imageModel.selectedAssetEntity.first ==
                              item),
                ),
              ),
            ),
          );
        case LoadingState.empty:
          return const _ImageItemWrapper(child: SizedBox());
      }
    });
  }
}

class _ImageItemWrapper extends StatelessWidget {
  final Widget child;
  const _ImageItemWrapper({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FadeTransitionWrapper(
      duration: const Duration(milliseconds: 100),
      child: SizedBox(
        width: (Get.width - 4.0) / 3.0,
        height: (Get.width - 4.0) / 3.0,
        child: child,
      ),
    );
  }
}

class _ImageItem extends GetView<MediaPickerController> {
  final AssetEntityResult assetEntityResult;
  final bool isSelected;
  final bool isLongPressed;
  final bool isDoubleTap;
  final bool isActive;
  const _ImageItem({
    Key? key,
    required this.assetEntityResult,
    required this.isSelected,
    required this.isLongPressed,
    required this.isDoubleTap,
    required this.isActive,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final counter =
        controller.imageModel.selectedAssetEntity.indexOf(assetEntityResult) +
            1;
    return Stack(
      children: [
        Positioned.fill(
          child: ExtendedImage.memory(
            assetEntityResult.thumnailByte ?? Uint8List(0),
            fit: BoxFit.cover,
          ),
        ),
        if (assetEntityResult.assetEntity!.type.mediaType.isVideo)
          Positioned(
            bottom: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.all(6.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.0),
                  color: Colors.white.withOpacity(0.5),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 2.0, vertical: 2.0),
                child: Text(
                  assetEntityResult.assetEntity?.duration.toMMss() ??
                      0.toMMss(),
                  style: kTheme.textTheme.bodySmall?.copyWith(
                    color: Colors.black87,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        if (isSelected || isDoubleTap) const _SelectedOverlay(),
        if (isActive)
          Positioned(
            top: isSelected ? (counter < 10 ? 0.0 : 5.0) : 5,
            right: 5,
            child: GestureDetector(
              onTap: isActive
                  ? () => controller.onImageTap(assetEntityResult)
                  : null,
              child: Visibility(
                visible: !isLongPressed,
                child: FadeThroughTransitionWrapper(
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 210),
                    curve: Curves.easeInOut,
                    padding: EdgeInsets.all(
                        isSelected ? (counter < 10 ? 8.0 : 4.0) : 10.0),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? kTheme.colorScheme.primary
                          : Colors.transparent,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: kTheme.colorScheme.background,
                        width: 1.5,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color:
                              kTheme.colorScheme.onBackground.withOpacity(0.2),
                          blurRadius: 4.0,
                          offset: const Offset(0, 2),
                        )
                      ],
                    ),
                    child: isSelected
                        ? Text(
                            '$counter',
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall
                                ?.copyWith(
                                  color: kTheme.colorScheme.onPrimary,
                                  fontWeight: FontWeight.bold,
                                ),
                          )
                        : null,
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}

class _SelectedOverlay extends StatelessWidget {
  const _SelectedOverlay();

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Container(
        color: kTheme.colorScheme.primary.withOpacity(0.4),
      ),
    );
  }
}

class _ImagePermissions extends StatelessWidget {
  final bool isPermanent;
  final VoidCallback? onPressed;

  const _ImagePermissions({
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
              'Cần quyền truy cập thư viện',
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
              'Chúng tôi cần quyền truy cập vào thư viện của bạn. ${isPermanent ? 'Bạn cần mở cài đặt và cấp quyền truy cập thư viện cho ứng dụng.' : ''}',
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
      ),
    );
  }
}

class _ErrorWidget extends StatelessWidget {
  final VoidCallback? callback;
  final String? message;
  const _ErrorWidget({Key? key, required this.callback, this.message})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ErrorOrEmptyWidget(
      callBack: callback,
      message: message ?? 'Đã xảy ra lỗi khi tải ảnh',
    );
  }
}
