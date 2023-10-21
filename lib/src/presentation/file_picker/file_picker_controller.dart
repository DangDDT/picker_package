import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../core/core.dart';
import '../@base/tab_picker_controller.dart';
import '../picker_menu/picker_menu_controller.dart';
import '../picker_menu/widgets/cancel_confirm_dialog.dart';

class FilePickerController extends GetxController
    implements TabPickerController {
  @override
  AttachmentType get attachmentType => AttachmentType.file;

  @override
  ScrollController? scrollController;

  @override
  Future<List<AttachmentData>> onSubmit() {
    return Future.value(selectedResult);
  }

  @override
  void onCloseTab() {
    _filePickerResult.call(null);
  }

  @override
  RxList<AttachmentData> selectedResult = RxList<AttachmentData>();

  late final List<FilePickerFunctionViewModel> listFunctionFilePicker;

  final _config = Get.find<ModuleConfig>(tag: CorePicker.packageName);

  final Rxn<FilePickerResult> _filePickerResult = Rxn<FilePickerResult>();

  final Rx<PermissionStatus> _permissionStatus =
      Rx<PermissionStatus>(PermissionStatus.denied);
  Rx<PermissionStatus> get permissionStatus => _permissionStatus;

  @override
  onInit() {
    super.onInit();
    listFunctionFilePicker =
        FilePickerFunctionViewModel.mapFilePickerFunctionViewModel(
      listFilePickerType:
          _config.filePickerOption?.filePickerTypes ?? FilePickerType.values,
      onTapPickFile: _onTapPickFile,
      onTapPickGallery: _onTapPickGallery,
      onTapPickerAudio: _onTapPickerAudio,
    );
  }

  Future<void> _onTapPickFile() async {
    _filePickerResult.call(null);
    try {
      _filePickerResult.value = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        dialogTitle: 'Tệp tin',
        allowedExtensions:
            _config.filePickerOption?.allowedExtensionsForFileCustomPicker,
        allowMultiple: _config.filePickerOption?.selectMultipleFiles ?? false,
        allowCompression: true,
      );
      if (_filePickerResult.value != null) {
        final mapResultToSelectedResult = _filePickerResult.value?.files
            .map(
              (e) => FileAttachmentData(
                e.path,
                File(e.path ?? ''),
                e.name,
                e.extension ?? 'unknown',
                e.size,
              ),
            )
            .toList();
        selectedResult.call(mapResultToSelectedResult);
      }
    } catch (e, stackTrace) {
      Logger.log('Error when pick file: $e',
          name: 'FilePickerController|_onTapPickFile', stackTrace: stackTrace);
    }
  }

  Future<void> _onTapPickGallery() async {
    _filePickerResult.call(null);
    try {
      _filePickerResult.value = await FilePicker.platform.pickFiles(
        type: FileType.media,
        allowCompression: true,
        dialogTitle: 'Thư viện',
        allowMultiple: _config.filePickerOption?.selectMultipleFiles ?? false,
      );
      if (_filePickerResult.value != null) {
        final mapResultToSelectedResult = _filePickerResult.value?.files
            .map(
              (e) => FileAttachmentData(
                e.path,
                File(e.path ?? ''),
                e.name,
                e.extension ?? 'unknown',
                e.size,
              ),
            )
            .toList();
        selectedResult.call(mapResultToSelectedResult);
      }
    } catch (e, stackTrace) {
      Logger.log('Error when pick file: $e',
          name: 'FilePickerController|_onTapPickFile', stackTrace: stackTrace);
    }
  }

  Future<void> _onTapPickerAudio() async {
    _filePickerResult.call(null);
    try {
      _filePickerResult.value = await FilePicker.platform.pickFiles(
        type: FileType.audio,
        dialogTitle: 'Âm thanh',
        allowMultiple: _config.filePickerOption?.selectMultipleFiles ?? false,
      );
      if (_filePickerResult.value != null) {
        final mapResultToSelectedResult = _filePickerResult.value?.files
            .map(
              (e) => FileAttachmentData(
                e.path,
                File(e.path ?? ''),
                e.name,
                e.extension ?? 'unknown',
                e.size,
              ),
            )
            .toList();
        selectedResult.call(mapResultToSelectedResult);
      }
    } catch (e, stackTrace) {
      Logger.log('Error when pick file: $e',
          name: 'FilePickerController|_onTapPickFile', stackTrace: stackTrace);
    }
  }

  @override
  Future<void> onClearSelectedResult() {
    selectedResult.call([]);
    return Future.value();
  }

  @override
  Future<void> onBack() async {
    if (selectedResult.isEmpty) {
      Get.back();
      return;
    }
    final isPop = await Get.dialog<bool?>(const CancelConfirmDialog());
    if (isPop == true) {
      Get.back();
    }
  }

  @override
  void onHeaderVerticalDragUpdate(DragUpdateDetails details) =>
      Get.find<PickerMenuController>().onHeaderVerticalDragUpdate.call(details);

  @override
  Future<void> onHeaderVerticalDragEnd(DragEndDetails details) async {
    if (isClosed) return;
    final pickerMenuController = Get.find<PickerMenuController>();
    pickerMenuController.onHeaderVerticalDragEnd.call(details);
  }
}

class FilePickerFunctionViewModel {
  final String title;
  final String subtitle;
  final Widget icon;
  final Function() onTap;
  FilePickerFunctionViewModel({
    required this.title,
    required this.subtitle,
    this.icon = const Icon(Icons.file_open),
    required this.onTap,
  });

  factory FilePickerFunctionViewModel.media({
    required Function() onTap,
  }) {
    return FilePickerFunctionViewModel(
      title: LanguageKeys.selectFromGalleryTitle.tr,
      subtitle: LanguageKeys.selectFromGallerySubtitle.tr,
      icon: LottieBuilder.asset(
        Assets.core_picker$assets_icons_20432_client_gallery_json,
        repeat: false,
        width: 40,
        height: 40,
      ),
      onTap: onTap,
    );
  }

  factory FilePickerFunctionViewModel.custom({
    required Function() onTap,
  }) {
    return FilePickerFunctionViewModel(
      title: LanguageKeys.selectFromFileTitle.tr,
      subtitle: LanguageKeys.selectFromFileSubtitle.tr,
      icon: LottieBuilder.asset(
        Assets.core_picker$assets_icons_20431_cloud_storage_json,
        repeat: false,
        width: 40,
        height: 40,
      ),
      onTap: onTap,
    );
  }

  factory FilePickerFunctionViewModel.audio({
    required Function() onTap,
  }) {
    return FilePickerFunctionViewModel(
      title: LanguageKeys.selectFromSoundTitle.tr,
      subtitle: LanguageKeys.selectFromSoundSubtitle.tr,
      icon: LottieBuilder.asset(
        Assets.core_picker$assets_icons_66746_music_json,
        repeat: false,
      ),
      onTap: onTap,
    );
  }

  static List<FilePickerFunctionViewModel> mapFilePickerFunctionViewModel({
    required List<FilePickerType> listFilePickerType,
    required Function() onTapPickFile,
    required Function() onTapPickGallery,
    required Function() onTapPickerAudio,
  }) {
    final List<FilePickerFunctionViewModel> listFilePickerFunctionViewModel =
        [];
    for (final filePickerType in listFilePickerType) {
      switch (filePickerType) {
        case FilePickerType.custom:
          listFilePickerFunctionViewModel.add(
            FilePickerFunctionViewModel.custom(
              onTap: onTapPickFile,
            ),
          );
          break;
        case FilePickerType.media:
          listFilePickerFunctionViewModel.add(
            FilePickerFunctionViewModel.media(
              onTap: onTapPickGallery,
            ),
          );
          break;
        case FilePickerType.audio:
          if (GetPlatform.isAndroid) {
            listFilePickerFunctionViewModel.add(
              FilePickerFunctionViewModel.audio(
                onTap: onTapPickerAudio,
              ),
            );
          }
          break;
      }
    }
    return listFilePickerFunctionViewModel;
  }
}
