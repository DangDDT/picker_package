import 'package:core_picker/src/domain/models/attachment_data.dart';
import 'package:get/get.dart';

import '../../../../core/core.dart';

abstract class BaseTabPickerMapper {
  Future<List<AttachmentData>> onSubmitFromType(AttachmentType attachmentType);

  void getTabPickerControllerFromType(AttachmentType attachmentType);

  RxList<AttachmentData> getSelectedAttachmentData(AttachmentType attachmentType);

  void onCloseTab(AttachmentType attachmentType);

  void disposeControllers();
}
