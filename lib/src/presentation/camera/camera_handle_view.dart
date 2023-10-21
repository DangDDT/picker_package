import 'dart:ui';

import 'package:camera/camera.dart';
import 'package:core_picker/src/presentation/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/core.dart';
import '../../domain/enums/private/camera_state.dart';
import '../shared/fade_scale_switcher_wrapper.dart';
import '../shared/shadow_text.dart';
import 'camera_handle_controller.dart';

class CameraHandleView extends GetView<CameraHandleController> {
  const CameraHandleView({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: _ToolWrapper(
          child: _CameraBuilder(),
        ),
      ),
    );
  }
}

class _CameraBuilder extends GetView<CameraHandleController> {
  const _CameraBuilder();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      switch (controller.cameraState.value) {
        case CameraState.initial:
        case CameraState.loading:
        case CameraState.ready:
          return GestureDetector(
            onTapUp: controller.onFocus,
            behavior: HitTestBehavior.opaque,
            child: Stack(
              children: [
                Positioned.fill(
                  child: CameraPreview(
                    controller.cameraController.value!,
                  ),
                ),
                Positioned.fill(
                  child: AnimatedOpacity(
                    opacity: controller.shouldBlur.value ? 1 : 0,
                    duration: const Duration(milliseconds: 410),
                    child: ClipRRect(
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
                        child: const ColoredBox(
                          color: Colors.white10,
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: controller.focusDy.value - 30,
                  left: controller.focusDx.value - 30,
                  child: AnimatedOpacity(
                    opacity: controller.isShowFocusCircle.value ? 1 : 0,
                    duration: const Duration(milliseconds: 60),
                    child: FadeThroughTransitionWrapper(
                      duration: const Duration(milliseconds: 410),
                      key: ValueKey(controller.isShowFocusCircle.value),
                      child: Container(
                        height: 60,
                        width: 60,
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          border: Border.all(
                            color: Colors.amber,
                            width: 1.5,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const Positioned(
                  top: 5,
                  right: 0,
                  left: 0,
                  child: _VideoDurationCard(),
                ),
                const Positioned(
                  bottom: 5,
                  right: 0,
                  left: 0,
                  child: UnconstrainedBox(child: _ZoomButtonGroup()),
                ),
              ],
            ),
          );
        error:
        case CameraState.error:
          return Container(
            color: kTheme.disabledColor,
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.visibility_off_outlined, size: 30),
                Text('Không hỗ trợ'),
                Text('chụp ảnh'),
              ],
            ),
          );
      }
    });
  }
}

class _ToolWrapper extends StatelessWidget {
  final Widget child;
  const _ToolWrapper({required this.child, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const _TopToolLayout(),
        Expanded(
          child: child,
        ),
        const _BottomToolLayout(),
      ],
    );
  }
}

class _VideoDurationCard extends GetView<CameraHandleController> {
  const _VideoDurationCard();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return FadeScaleSwitcherWrapper(
        duration: const Duration(milliseconds: 410),
        child: Visibility(
          key: ValueKey(controller.isRecordingInProgress.value),
          visible: controller.isRecordingInProgress.value,
          child: Container(
            width: Get.width * 0.2,
            height: kTheme.textTheme.bodySmall!.fontSize! * 3.5,
            decoration: BoxDecoration(
              color: Colors.redAccent,
              borderRadius: BorderRadius.circular(50),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ShadowText(
                  controller.countTimeWorker.currentDuration.value.toHHmmss(),
                  style: kTheme.textTheme.titleMedium!.copyWith(
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}

class _ZoomButtonGroup extends GetView<CameraHandleController> {
  const _ZoomButtonGroup();

  static const _zoomValues = [1, 2, 4, 8];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: kTheme.textTheme.bodySmall!.fontSize! * 3.5,
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.2),
        borderRadius: BorderRadius.circular(50),
      ),
      child: ListView.separated(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 6),
        itemBuilder: (context, index) {
          final zoomButtonValue = _zoomValues[index];
          return Obx(
            () {
              return _ZoomButton(
                value: zoomButtonValue.toString(),
                isSelected:
                    controller.currentZoomLevel.value.ceil() == zoomButtonValue,
                onPressed: () =>
                    controller.setCurrentZoomLevel(zoomButtonValue.toDouble()),
              );
            },
          );
        },
        separatorBuilder: (context, index) => const SizedBox(width: 12),
        itemCount: _zoomValues.length,
      ),
    );
  }
}

class _ZoomButton extends StatelessWidget {
  final String value;
  final VoidCallback? onPressed;
  final bool isSelected;
  const _ZoomButton({
    required this.value,
    Key? key,
    required this.isSelected,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding:
            EdgeInsets.symmetric(horizontal: 9, vertical: isSelected ? 12 : 6),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.3),
          shape: BoxShape.circle,
        ),
        child: AnimatedSize(
          key: ValueKey(value),
          alignment: Alignment.bottomLeft,
          duration: const Duration(milliseconds: 110),
          child: Center(
            child: Text(
              '$value${isSelected ? 'x' : ''}',
              style: kTheme.textTheme.bodySmall!.copyWith(
                color: isSelected ? Colors.amber : Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: isSelected
                    ? (kTheme.textTheme.bodySmall!.fontSize! * 1.1)
                    : kTheme.textTheme.bodySmall!.fontSize!,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _TopToolLayout extends StatelessWidget {
  const _TopToolLayout();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: kToolbarHeight,
      color: Colors.black,
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _FlashButton(),
          _ResolutionPresetButton(),
        ],
      ),
    );
  }
}

class _FlashButton extends GetView<CameraHandleController> {
  const _FlashButton();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final mode = controller.currentFlashMode.value;
      return GestureDetector(
        onTap: controller.onSwitchFlashMode,
        behavior: HitTestBehavior.opaque,
        child: FadeSlideTransition(
          key: ValueKey(mode),
          duration: const Duration(milliseconds: 240),
          child: Container(
            margin: const EdgeInsets.all(8),
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: mode == FlashState.flashOn
                  ? Colors.amber
                  : Colors.transparent,
              shape: BoxShape.circle,
              border: const Border.fromBorderSide(
                BorderSide(color: Colors.white, width: 1),
              ),
            ),
            child: Center(
              child: Builder(builder: (_) {
                switch (mode) {
                  case FlashState.flashOff:
                    return const Icon(
                      Icons.flash_off,
                      color: Colors.white,
                      size: 16,
                    );
                  case FlashState.flashOn:
                    return const Icon(
                      Icons.flash_on,
                      color: Colors.black,
                      size: 16,
                    );
                }
              }),
            ),
          ),
        ),
      );
    });
  }
}

class _ResolutionPresetButton extends GetView<CameraHandleController> {
  const _ResolutionPresetButton();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return GestureDetector(
        onTap: controller.onChangeResolutionPreset,
        behavior: HitTestBehavior.opaque,
        child: Padding(
          padding: const EdgeInsets.only(right: 8, top: 0),
          child: Row(
            children: [
              Text(
                LanguageKeys.quanlity.tr,
                style:
                    kTheme.textTheme.bodyMedium!.copyWith(color: Colors.white),
              ),
              kGapW8,
              Container(
                decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: Colors.white),
                width: 8 / 2,
                height: 8 / 2,
              ),
              kGapW8,
              AnimatedSize(
                duration: const Duration(milliseconds: 240),
                curve: Curves.decelerate,
                child: ShadowText(
                  controller.currentResolutionPreset.value.name,
                  style: kTheme.textTheme.bodyMedium!.copyWith(
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}

class _BackwardButton extends StatelessWidget {
  const _BackwardButton();

  @override
  Widget build(BuildContext context) {
    return IconButton(
      style: IconButton.styleFrom(
        fixedSize: const Size(50, 50),
        shape: const CircleBorder(),
        padding: const EdgeInsets.all(8),
        backgroundColor: Colors.white.withOpacity(0.2),
      ),
      onPressed: () => Get.back(),
      icon: const Center(
        child: Icon(
          Icons.close,
          color: Colors.white,
        ),
      ),
    );
  }
}

class _BottomToolLayout extends GetView<CameraHandleController> {
  const _BottomToolLayout();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return AnimatedSize(
        duration: const Duration(milliseconds: 240),
        child: Column(
          children: [
            FadeScaleSwitcherWrapper(
              child: Visibility(
                key: ValueKey(controller.isRecordingInProgress.value),
                visible: !controller.isRecordingInProgress.value,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                  height: 40,
                  color: Colors.black,
                  child: const Center(
                    child: _CameraModeGroup(),
                  ),
                ),
              ),
            ),
            Container(
              width: double.infinity,
              height: 140,
              color: Colors.black,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Expanded(child: _BackwardButton()),
                  kGapH8,
                  const Expanded(child: _CaptureButton()),
                  kGapH8,
                  Expanded(
                    child: FadeScaleSwitcherWrapper(
                      child: Visibility(
                        key: ValueKey(controller.isRecordingInProgress.value),
                        visible: !controller.isRecordingInProgress.value,
                        child: const _CameraSwitchButton(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
}

class _CameraModeGroup extends GetView<CameraHandleController> {
  const _CameraModeGroup();

  @override
  Widget build(BuildContext context) {
    return RotatedBox(
      quarterTurns: 3,
      child: ListWheelScrollView(
        itemExtent: 100,
        diameterRatio: .65,
        controller: controller.scrollController,
        physics: const FixedExtentScrollPhysics(),
        onSelectedItemChanged: controller.onSwitchCameraMode,
        children: (controller.cameraModes)
            .map(
              (e) => Obx(() {
                return _ListWheelScrollViewItem(
                  title: e.title.toUpperCase(),
                  isSelected: controller.currentCameraMode.value == e,
                  onTap: () => controller.onTapSwitchCameraMode(e),
                );
              }),
            )
            .toList(),
      ),
    );
  }
}

class _CameraSwitchButton extends GetView<CameraHandleController> {
  const _CameraSwitchButton();

  @override
  Widget build(BuildContext context) {
    return IconButton(
      style: IconButton.styleFrom(
        fixedSize: const Size(50, 50),
        shape: const CircleBorder(),
        padding: const EdgeInsets.all(8),
        backgroundColor: Colors.white.withOpacity(0.2),
      ),
      onPressed: controller.onSwitchCamera,
      icon: const Center(
        child: Icon(
          Icons.flip_camera_ios,
          color: Colors.white,
        ),
      ),
    );
  }
}

class _CaptureButton extends GetView<CameraHandleController> {
  const _CaptureButton();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final bool isPhotoMode = controller.currentCameraMode.value.isPhoto;
      return AnimatedSwitcher(
        duration: const Duration(milliseconds: 240),
        transitionBuilder: (child, animation) {
          return ScaleTransition(
            scale: animation,
            child: child,
          );
        },
        child: GestureDetector(
          key: ValueKey(isPhotoMode),
          onTap: controller.onCapture,
          behavior: HitTestBehavior.opaque,
          child: Container(
            padding: const EdgeInsets.all(4),
            height: (Get.width / 6).clamp(70, 150),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isPhotoMode ? Colors.white : Colors.redAccent,
            ),
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.black,
                  width: 2,
                ),
              ),
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 120),
                transitionBuilder: (child, animation) {
                  return ScaleTransition(
                    scale: animation,
                    child: child,
                  );
                },
                child: controller.isRecordingInProgress.value
                    ? Center(
                        key: ValueKey(controller.isRecordingInProgress.value),
                        child: const Icon(
                          Icons.stop,
                          color: Colors.white,
                          size: 40,
                        ),
                      )
                    : null,
              ),
            ),
          ),
        ),
      );
    });
  }
}

class _ListWheelScrollViewItem extends StatelessWidget {
  final String title;
  final bool isSelected;
  final VoidCallback onTap;
  const _ListWheelScrollViewItem({
    Key? key,
    required this.title,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 100,
        height: 100,
        child: RotatedBox(
          quarterTurns: 1,
          child: Text(
            title,
            style: kTheme.textTheme.titleMedium!.copyWith(
              color: isSelected ? Colors.amber : Colors.white,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
