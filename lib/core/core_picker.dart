library quy_hoach_module;

export 'package:core_picker/src/domain/enums/public/attachment_type.dart';
export 'package:core_picker/src/domain/models/attachment_result.dart';
export 'package:core_picker/src/domain/models/attachment_data.dart';
export 'package:core_picker/src/domain/enums/public/file_picker_type.dart';
export 'package:core_picker/src/domain/enums/public/camera_mode.dart';
export 'package:core_picker/src/domain/models/preview_return_value.dart';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../src/presentation/picker_menu/picker_menu_view.dart';
import 'core.dart';

class CorePicker {
  static const packageName = "core_picker-$version";
  static const version = "1.0.0";
  static List<GetPage> get pageRoutes => ModuleRouter.routes;
  static TranslateManager get l10n => TranslateManager();
  static const bool _initialized = false;

  static Future<void> init() async {}

  /// `showPickerMenu` là chức năng chính của module này, nó sẽ hiển thị một menu chọn ảnh, file, vị trí, ... và trả về kết quả sau khi người dùng chọn xong.
  ///
  /// @param
  /// - `isShowLog`: Cho phép hiển thị log của module này (default = false).
  /// - `submitButtonTitle`: Tiêu đề của nút submit (default = null).
  /// - `submitButtonIcon`: Icon của nút submit (default = Icons.check).
  /// - `attachmentTypes`: Danh sách các loại attachment mà menu này hỗ trợ (default = [AttachmentType.image, AttachmentType.file]).
  /// - `imagePickerOption`: Cấu hình cho chức năng chọn ảnh (default = ImagePickerOption()).
  /// - `filePickerOption`: Cấu hình cho chức năng chọn file (default = FilePickerOption()).
  /// - `locationPickerOption`: Cấu hình cho chức năng chọn vị trí (default = LocationPickerOption()).
  ///
  /// @description
  ///
  /// `ImagePickerOption`: Cấu hình cho chức năng chọn ảnh.
  ///  - `maxImagePerLoadTime`: Số lượng ảnh tối đa được load lên màn hình mỗi lần (default = 100).
  ///  - `imagePerRow`: Số lượng ảnh trên mỗi dòng (default = 3).
  ///  - `isUseCamera`: Cho phép sử dụng camera (default = true).
  ///  - `isUseCameraInsideAlbum`: Cho phép camera tự động kích hoạt trong album (default = true).
  ///  - `isShowPreviewInfo`: Hiển thị thông tin ảnh khi xem trước (default = false).
  ///  - `isUseCaptionField`: Cho phép nhập caption cho ảnh (default = true).
  ///  - `captionFieldConfig`: Cấu hình cho caption (default = CaptionFieldConfig(maxCaptionLength: 100)).
  ///
  /// `LocationPickerOption`: Cấu hình cho chức năng chọn vị trí.
  ///  - `isUseCaptionField`: Cho phép nhập caption cho vị trí (default = true).
  ///  - `captionFieldConfig`: Cấu hình cho caption (default = CaptionFieldConfig(maxCaptionLength: 100)).
  ///
  /// `FilePickerOption`: Cấu hình cho chức năng chọn file.
  ///  - `isUseCaptionField`: Cho phép nhập caption cho file (default = true).
  ///  - `captionFieldConfig`: Cấu hình cho caption (default = CaptionFieldConfig(maxCaptionLength: 100)).
  ///  - `allowedExtensionsForFileCustomPicker`: Danh sách các đuôi file được phép chọn trong chọn theo hình thức custom (default = null).
  ///  - `filePickerType`: Hình thức chọn file (default = FilePickerType.values).
  ///
  /// `CaptionFieldConfig`: Cấu hình cho caption.
  ///  - `maxCaptionLength`: Số lượng ký tự tối đa cho phép nhập (default = 100).
  ///  - `captionHint`: Hint cho caption (default = "Nhập bất kỳ gì bạn muốn vào đây").
  ///
  /// `FilePickerType`: Hình thức chọn file.
  ///  - `FilePickerType.audio`: Chọn file âm thanh.
  ///  - `FilePickerType.custom`: Chọn file theo danh sách đuôi file cho phép.
  ///  - `FilePickerType.image`: Chọn file ảnh từ thư viện.
  ///
  /// @return
  ///  - `AttachmentResult`: Kết quả trả về sau khi người dùng chọn xong.
  ///
  ///@example
  ///
  /// ```dart
  /// final result = await CorePicker.showPickerMenu(
  ///   isShowLog: true,
  ///   submitButtonTitle: "Gửi",
  ///   submitButtonIcon: Icons.send,
  ///   attachmentTypes: [
  ///    AttachmentType.image,
  ///    AttachmentType.file,
  ///    AttachmentType.location,
  ///   ],
  ///   imagePickerOption: ImagePickerOption(
  ///   maxImagePerLoadTime: 50,
  ///   imagePerRow: 4,
  ///   isUseCamera: true,
  ///   isUseCameraInsideAlbum: true,
  ///   isShowPreviewInfo: true,
  ///   isUseCaptionField: true,
  ///   captionFieldConfig: CaptionFieldConfig(
  ///      maxCaptionLength: 100,
  ///      captionHint: "Nhập caption cho ảnh",
  ///     ),
  ///   ),
  ///   filePickerOption: FilePickerOption(
  ///   isUseCaptionField: true,
  ///   captionFieldConfig: CaptionFieldConfig(
  ///     maxCaptionLength: 100,
  ///     captionHint: "Nhập caption cho file",
  ///   ),
  ///   allowedExtensionsForFileCustomPicker: [
  ///    "pdf",
  ///    "doc",
  ///    "docx",
  ///    "xls",
  ///   ],
  ///   filePickerType: FilePickerType.custom,
  ///  ),
  ///   locationPickerOption: LocationPickerOption(
  ///   isUseCaptionField: true,
  ///   captionFieldConfig: CaptionFieldConfig(
  ///    maxCaptionLength: 100,
  ///    captionHint: "Nhập caption cho vị trí",
  ///   ),
  ///  ),
  /// );
  /// ```
  ///
  static Future<AttachmentResult?> showPickerMenu({
    bool isShowLog = false,
    String? submitButtonTitle,
    IconData submitButtonIcon = Icons.check,
    List<AttachmentType> attachmentTypes = const [
      AttachmentType.media,
      AttachmentType.file,
    ],
    MediaPickerOption? mediaPickerOption,
    FilePickerOption? filePickerOption,
    LocationPickerOption? locationPickerOption,
  }) async {
    GlobalBinding.setUpLocator(
      submitButtonTitle: submitButtonTitle,
      submitButtonIcon: submitButtonIcon,
      categories: attachmentTypes,
      enableLog: isShowLog,
      mediaPickerOption: (mediaPickerOption
            ?..maxMediaPerLoadTime =
                mediaPickerOption.maxMediaPerLoadTime.clamp(15, 99999)) ??
          MediaPickerOption(),
      filePickerOption: filePickerOption ?? const FilePickerOption(),
      locationPickerOption:
          locationPickerOption ?? const LocationPickerOption(),
    );
    final context = Get.context!;
    int durationMls = 110;
    final isFocus = FocusScope.of(context).hasFocus;
    if (isFocus) {
      durationMls = 310;
      FocusScope.of(context).unfocus();
    }
    final result =
        await Future.delayed(Duration(milliseconds: durationMls), () async {
      final result = await Navigator.push<AttachmentResult?>(
        context,
        PageRouteBuilder(
          opaque: false,
          barrierDismissible: true,
          barrierColor: Colors.black.withOpacity(0.5),
          pageBuilder: (_, __, ___) => const PickerMenuView(),
          transitionDuration: const Duration(milliseconds: 210),
          transitionsBuilder: (_, animation, __, child) {
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0, 1),
                end: Offset.zero,
              ).animate(animation),
              child: child,
            );
          },
        ),
      );
      await GlobalBinding.dispose();
      return result;
    });
    return result;
  }

  static Future<PreviewReturnValue?> goCamera({
    bool logger = false,
    List<CameraMode> cameraModes = CameraMode.values,
  }) async {
    GlobalBinding.setUpLocator(
      enableLog: logger,
      submitButtonIcon: Icons.check,
      submitButtonTitle: "Hoàn tất",
      mediaPickerOption: MediaPickerOption(
        isUseCaptionField: false,
      ),
    );
    List<CameraDescription> cameras = await availableCameras();
    final result = await Get.toNamed(goCameraRoute,
        arguments: {'cameras': cameras, 'cameraModes': cameraModes});
    await GlobalBinding.dispose();
    return result;
  }
}
