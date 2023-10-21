import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/core.dart';

enum CameraState {
  initial,
  loading,
  ready,
  error,
}

class CameraThumbnailController extends GetxController
    with WidgetsBindingObserver {
  CameraController? _cameraController;
  CameraController? get cameraController => _cameraController;

  List<CameraDescription> _cameras = [];
  List<CameraDescription> get cameras => _cameras;

  final Rx<bool> _isCameraReady = false.obs;
  Rx<bool> get isCameraReady => _isCameraReady;

  final Rx<CameraState> _cameraState = CameraState.initial.obs;
  Rx<CameraState> get cameraState => _cameraState;

  final Rx<bool> _shouldBlur = false.obs;
  Rx<bool> get shouldBlur => _shouldBlur;

  @override
  Future<void> onInit() async {
    _cameras = await availableCameras();
    _initThumbnailCamera();
    _registerListener();
    super.onInit();
  }

  Future<void> _initThumbnailCamera() async {
    _shouldBlur.call(true);
    _cameraState.call(CameraState.loading);
    if (_cameras.isEmpty) {
      _cameraState.call(CameraState.error);
      return;
    }
    _cameraController = CameraController(
      _cameras.first,
      ResolutionPreset.low,
    );
    _cameraController?.initialize().then((_) async {
      if (isClosed) {
        return;
      }
      await Future.delayed(const Duration(milliseconds: 210), () {});
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
      Logger.log('Camera init error',
          name: 'CameraHandleController', stackTrace: stackTrace);
    });
  }

  _registerListener() {
    _cameraController?.addListener(() async {
      if (_cameraController?.value.isInitialized != _isCameraReady.value) {
        _isCameraReady.call(cameraController?.value.isInitialized);
        if (_isCameraReady.value) {
          await Future.delayed(const Duration(milliseconds: 210), () {
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
    if (!_cameraController!.value.isInitialized) {
      return;
    }
    if (state == AppLifecycleState.inactive) {
      // Free up memory when camera not active
      _shouldBlur.call(true);
      await _cameraController?.dispose();
    } else if (state == AppLifecycleState.resumed) {
      // Reinitialize the camera with same properties
      _initThumbnailCamera();
    }
  }

  @override
  void dispose() {
    _cameraController?.dispose();
    super.dispose();
  }
}
