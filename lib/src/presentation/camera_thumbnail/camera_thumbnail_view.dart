import 'dart:ui';

import 'package:camera/camera.dart';
import 'package:core_picker/core/core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import 'camera_thumbnail_controller.dart';

class CameraThumnailView extends StatelessWidget {
  const CameraThumnailView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CameraThumbnailController>(
      init: CameraThumbnailController(),
      builder: (controller) => Obx(
        () {
          switch (controller.cameraState.value) {
            case CameraState.initial:
            case CameraState.loading:
            case CameraState.ready:
              if (controller.cameraController == null) {
                continue error;
              }
              return Stack(
                children: [
                  Positioned.fill(
                    child: CameraPreview(
                      controller.cameraController!,
                    ),
                  ),
                  Positioned.fill(
                    child: AnimatedOpacity(
                      opacity: controller.shouldBlur.value ? 1 : 0,
                      duration: const Duration(milliseconds: 210),
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
                    top: 0,
                    right: 0,
                    child: LottieBuilder.asset(
                      Assets.core_picker$assets_icons_63405_camera_json,
                      width: 40,
                      height: 40,
                      reverse: true,
                    ),
                  ),
                ],
              );
            error:
            case CameraState.error:
              return GestureDetector(
                onTap: () => {},
                child: Container(
                  color: kTheme.disabledColor,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.visibility_off_outlined, size: 30),
                      FittedBox(
                        child: Text(
                          'Không hỗ trợ',
                          style: kTheme.textTheme.bodySmall,
                        ),
                      ),
                      FittedBox(
                        child: Text(
                          'truy cập camera',
                          style: kTheme.textTheme.bodySmall,
                        ),
                      ),
                    ],
                  ),
                ),
              );
          }
        },
      ),
    );
  }
}
