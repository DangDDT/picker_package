// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:vif_previewer/previewer.dart';
// ignore: depend_on_referenced_packages
import '../../../core/core.dart';
import '../../../core/utils/helpers/toast.dart';
import '../../domain/domain.dart';
// ignore: depend_on_referenced_packages

class CameraHandleController extends GetxController
    with WidgetsBindingObserver, CountTimeMixin {
  final ModuleConfig moduleConfig =
      Get.find<ModuleConfig>(tag: CorePicker.packageName);

  late final List<CameraDescription> _cameras;
  late List<CameraMode> _cameraModes;
  List<CameraMode> get cameraModes => _cameraModes;

  final Rxn<CameraController> _cameraController = Rxn<CameraController>();
  Rxn<CameraController> get cameraController => _cameraController;

  final FixedExtentScrollController _scrollController =
      FixedExtentScrollController(initialItem: CameraMode.photo.index);
  FixedExtentScrollController get scrollController => _scrollController;

  final Rx<bool> _isCameraReady = false.obs;
  Rx<bool> get isCameraReady => _isCameraReady;

  final Rx<CameraState> _cameraState = CameraState.initial.obs;
  Rx<CameraState> get cameraState => _cameraState;

  final Rx<ResolutionPreset> _currentResolutionPreset =
      ResolutionPreset.low.obs;
  set setCurrentResolutionPreset(ResolutionPreset value) =>
      _currentResolutionPreset.call(value);
  Rx<ResolutionPreset> get currentResolutionPreset => _currentResolutionPreset;

  late final Rx<CameraDescription> _currentCamera;
  Rx<CameraDescription> get currentCamera => _currentCamera;

  final Rx<FlashState> _currentFlashMode = FlashState.flashOff.obs;
  Rx<FlashState> get currentFlashMode => _currentFlashMode;

  final RxBool _shouldBlur = false.obs;
  RxBool get shouldBlur => _shouldBlur;

  final Rx<double> _maxZoomLevel = 0.0.obs;
  Rx<double> get maxZoomLevel => _maxZoomLevel;

  final Rx<double> _minZoomLevel = 0.0.obs;
  Rx<double> get minZoomLevel => _minZoomLevel;

  final Rx<double> _currentZoomLevel = 0.0.obs;
  Rx<double> get currentZoomLevel => _currentZoomLevel;

  final Rx<bool> _isShowFocusCircle = false.obs;
  Rx<bool> get isShowFocusCircle => _isShowFocusCircle;

  final Rx<double> _focusDx = 0.0.obs;
  Rx<double> get focusDx => _focusDx;

  final Rx<double> _focusDy = 0.0.obs;
  Rx<double> get focusDy => _focusDy;

  late final Rx<CameraMode> _currentCameraMode;
  Rx<CameraMode> get currentCameraMode => _currentCameraMode;

  final Rx<bool> _isRecordingInProgress = false.obs;
  Rx<bool> get isRecordingInProgress => _isRecordingInProgress;

  @override
  void onInit() {
    _cameras = Get.arguments['cameras'] as List<CameraDescription>;
    List<CameraMode>? cameraModeConfig;
    if (moduleConfig.mediaPickerOption?.mediaPickerTypes.isOnlyImage ?? false) {
      cameraModeConfig = [CameraMode.photo];
    } else if (moduleConfig.mediaPickerOption?.mediaPickerTypes.isOnlyVideo ??
        false) {
      cameraModeConfig = [CameraMode.video];
    }
    final cameraModeParams =
        cameraModeConfig ?? Get.arguments?['cameraModes'] as List<CameraMode>?;
    if (cameraModeParams == null || cameraModeParams.isEmpty) {
      _cameraModes = CameraMode.values;
    } else {
      _cameraModes = cameraModeParams;
    }
    _currentCameraMode = Rx<CameraMode>(
      _cameraModes.length == 2 ? CameraMode.photo : _cameraModes[0],
    );
    _currentCamera = Rx<CameraDescription>(_cameras[0]);
    _cameraController.call(
        CameraController(_currentCamera.value, _currentResolutionPreset.value));
    initNewCamera();
    super.onInit();
  }

  Future<void> initNewCamera() async {
    _shouldBlur.call(true);
    cameraState.call(CameraState.loading);
    // Instantiating the camera controller
    final CameraController cameraController = CameraController(
      _currentCamera.value,
      _currentResolutionPreset.value,
      imageFormatGroup: GetPlatform.isIOS ? ImageFormatGroup.yuv420 : null,
    );

    // Dispose the previous controller
    // Initialize controller
    await Future.delayed(const Duration(milliseconds: 210), () {});
    cameraController.initialize().then((_) async {
      if (isClosed) {
        return;
      }
      await Future.delayed(const Duration(milliseconds: 410), () {
        _cameraController.call(cameraController);
        _shouldBlur.call(false);
        if (_cameraController.value == null) {
          _cameraState.call(CameraState.error);
        }
      });
      final maxZoomLevel = await cameraController.getMaxZoomLevel();
      final minZoomLevel = await cameraController.getMinZoomLevel();
      _maxZoomLevel.call(maxZoomLevel);
      _currentZoomLevel.call(minZoomLevel);
      _minZoomLevel.call(minZoomLevel);
      update();
    }).catchError((e, stackTrace) {
      _cameraState.call(CameraState.error);
      if (e is CameraException) {
        switch (e.code) {
          case 'CameraAccessDenied':
            Logger.log('Camera access denied',
                name: 'CameraHandleController', stackTrace: stackTrace);
        }
      }
      Logger.log(e.toString(),
          name: 'CameraHandleController', stackTrace: stackTrace);
    });
    cameraController.addListener(() async {
      if (cameraController.value.isInitialized != _isCameraReady.value) {
        _isCameraReady.call(cameraController.value.isInitialized);
        if (_isCameraReady.value) {
          await Future.delayed(const Duration(milliseconds: 410), () {
            _cameraState.call(CameraState.ready);
            _shouldBlur.call(false);
          });
        }
      }
    });
  }

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    // App state changed before we got the chance to initialize.
    if (_cameraController.value == null ||
        !_cameraController.value!.value.isInitialized) {
      return;
    }
    if (state == AppLifecycleState.inactive) {
      // Free up memory when camera not active
      _shouldBlur.call(true);
      await _cameraController.value!.dispose();
    } else if (state == AppLifecycleState.resumed) {
      // Reinitialize the camera with same properties
      initNewCamera();
    }
  }

  @override
  void dispose() {
    _cameraController.value?.dispose();
    _scrollController.dispose();
    countTimeWorker.disposeTimer();
    super.dispose();
  }

  Future<void> onChangeResolutionPreset() async {
    final index =
        ResolutionPreset.values.indexOf(_currentResolutionPreset.value);
    final nextIndex = index + 1;
    if (nextIndex >= ResolutionPreset.values.length) {
      _currentResolutionPreset.call(ResolutionPreset.values[0]);
    } else {
      _currentResolutionPreset.call(ResolutionPreset.values[nextIndex]);
    }
    initNewCamera();
  }

  Future<void> onSwitchCamera() async {
    final index = _cameras.indexOf(_currentCamera.value);
    final nextIndex = index + 1;
    if (nextIndex >= _cameras.length) {
      _currentCamera.call(_cameras[0]);
    } else {
      _currentCamera.call(_cameras[nextIndex]);
    }
    initNewCamera();
  }

  Future<void> onSwitchFlashMode() async {
    _currentFlashMode.call(
      _currentFlashMode.value == FlashState.flashOff
          ? FlashState.flashOn
          : FlashState.flashOff,
    );
    await _cameraController.value!.setFlashMode(
      _currentFlashMode.value == FlashState.flashOn
          ? FlashMode.torch
          : FlashMode.off,
    );
  }

  Future<void> setCurrentZoomLevel(double zoomLevel) async {
    _currentZoomLevel.call(zoomLevel);
    _cameraController.value?.setZoomLevel(zoomLevel);
  }

  Future<void> onCapture() async {
    switch (_currentCameraMode.value) {
      case CameraMode.photo:
        {
          await _takePicture();
          break;
        }
      case CameraMode.video:
        {
          if (_isRecordingInProgress.value) {
            await _stopVideoRecording();
            break;
          } else {
            await _startVideoRecording();
            break;
          }
        }
    }
  }

  Future<void> _takePicture() async {
    final context = Get.context!;
    context.loaderOverlay.show();
    try {
      if (_cameraController.value == null || !_isCameraReady.value) {
        throw ValidationException(
          ValidationExceptionKind.invalidInput,
          message: 'Camera is not ready',
          advice: 'Có lỗi khi khởi động camera, vui lòng khởi động lại',
        );
      }
      if (_cameraController.value?.value.isTakingPicture ?? false) {
        context.loaderOverlay.hide();
        // A capture is already pending, do nothing.
        return;
      }
      final XFile cameraResult = await _cameraController.value!
          .takePicture()
          .catchError((e, stackTrace) {
        throw ValidationException(
          ValidationExceptionKind.invalidOutput,
          message: 'Take picture failed',
          advice: 'Có lỗi khi chụp ảnh, vui lòng thử lại sau',
        );
      });
      // ignore: use_build_context_synchronously
      context.loaderOverlay.hide();
      final result = await Get.toNamed(previewRoute, arguments: {
        "data": [
          MediaPreviewData.fromFile(
            type: MediaType.image,
            file: File(cameraResult.path),
          )
        ],
        'isPaging': false,
        'physic': const NeverScrollableScrollPhysics(),
        'isShowSubmitBar': true,
      }) as PreviewReturnValue?;
      if (result != null) {
        Get.back(
            result: result
              ..setFile = cameraResult
              ..setMediaType = MediaType.image);
      } else {
        await _cameraController.value?.resumePreview();
      }
    } on ValidationException catch (e) {
      context.loaderOverlay.hide();
      Logger.log(e.toString(), name: 'CameraHandleController');
      Toast.error(message: 'Có lỗi khi chụp ảnh, vui lòng thử lại sau');
    } catch (e, stackTrace) {
      context.loaderOverlay.hide();
      Logger.log(e.toString(),
          name: 'CameraHandleController', stackTrace: stackTrace);

      Toast.error(message: 'Có lỗi khi chụp ảnh, vui lòng thử lại sau');
    }
  }

  Future<void> _startVideoRecording() async {
    if (_cameraController.value == null || !_isCameraReady.value) {
      // Camera is not ready or already recording.
      return;
    }

    if (_cameraController.value!.value.isRecordingVideo) {
      // A recording has already started, do nothing.
      return;
    }
    try {
      unawaited(_cameraController.value?.startVideoRecording());
      countTimeWorker.startTimer();
      _isRecordingInProgress.call(true);
    } on CameraException catch (e, stackTrace) {
      isRecordingInProgress.call(false);
      Logger.log('CameraException: ${e.description}',
          name: 'CameraHandleController', stackTrace: stackTrace);
    }
  }

  Future<void> _stopVideoRecording() async {
    final context = Get.context!;
    context.loaderOverlay.show();
    if (_cameraController.value == null || !_isCameraReady.value) {
      throw ValidationException(
        ValidationExceptionKind.invalidInput,
        message: 'Camera is not ready',
        advice: 'Có lỗi khi khởi động camera, vui lòng khởi động lại',
      );
    }

    if (!_cameraController.value!.value.isRecordingVideo) {
      context.loaderOverlay.hide();
      // Recording is already is stopped state
      return;
    }
    try {
      final XFile file = await _cameraController.value!.stopVideoRecording();

      countTimeWorker.resetTimer();

      _isRecordingInProgress.call(false);

      // ignore: use_build_context_synchronously
      context.loaderOverlay.hide();

      // ignore: unused_local_variable
      final result = await Get.toNamed(previewRoute, arguments: {
        "data": [
          MediaPreviewData.fromFile(
            type: MediaType.video,
            file: File(file.path),
          )
        ],
        'isPaging': false,
        'physic': const NeverScrollableScrollPhysics(),
        'isShowSubmitBar': true,
      }) as PreviewReturnValue?;

      if (result != null) {
        Get.back(
            result: result
              ..setFile = file
              ..setMediaType = MediaType.video);
      } else {
        _currentCameraMode.call(CameraMode.photo);
        await _cameraController.value?.resumePreview();
      }
    } on ValidationException catch (e) {
      context.loaderOverlay.hide();
      Logger.log(e.toString(), name: 'CameraHandleController');
      Toast.error(message: 'Có lỗi khi chụp ảnh, vui lòng thử lại sau');
    } catch (e, stackTrace) {
      context.loaderOverlay.hide();
      Logger.log(e.toString(),
          name: 'CameraHandleController', stackTrace: stackTrace);
      Toast.error(message: 'Có lỗi khi chụp ảnh, vui lòng thử lại sau');
    }
  }

  Future<void> onFocus(TapUpDetails? details) async {
    if (_isCameraReady.value) {
      _isShowFocusCircle.call(true);
      _focusDx.call(details?.localPosition.dx);
      _focusDy.call(details?.localPosition.dy);

      double fullWidth = Get.width;
      double cameraHeight =
          fullWidth * (_cameraController.value?.value.aspectRatio ?? 1 / 1.95);

      double xp = _focusDx.value / fullWidth;
      double yp = _focusDy.value / cameraHeight;

      Offset point = Offset(xp, yp);
      await _cameraController.value?.setFocusPoint(point);
      await _cameraController.value?.setExposurePoint(point);
      Future.delayed(const Duration(milliseconds: 410)).whenComplete(() {
        _isShowFocusCircle.call(false);
      });
    }
  }

  void onSwitchCameraMode(int index) {
    _currentCameraMode.call(_cameraModes[index] ?? CameraMode.photo);
  }

  void onTapSwitchCameraMode(CameraMode mode) {
    _currentCameraMode.call(mode);
    scrollController.animateToItem(
      _currentCameraMode.value.index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }
}

enum FlashState { flashOff, flashOn }

extension ResolutionPresetExt on ResolutionPreset {
  String get name {
    switch (this) {
      case ResolutionPreset.max:
        return LanguageKeys.maximum.tr;
      case ResolutionPreset.ultraHigh:
        return LanguageKeys.extremelyHigh.tr;
      case ResolutionPreset.veryHigh:
        return LanguageKeys.veryHigh.tr;
      case ResolutionPreset.high:
        return LanguageKeys.high.tr;
      case ResolutionPreset.medium:
        return LanguageKeys.medium.tr;
      case ResolutionPreset.low:
        return LanguageKeys.low.tr;
      default:
        return 'unknown';
    }
  }
}
