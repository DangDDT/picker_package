import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/core.dart';
import '../../domain/models/attachment_data.dart';

abstract class TabPickerController extends GetxController {
  TabPickerController({this.scrollController, required this.attachmentType});

  final AttachmentType attachmentType;

  final ScrollController? scrollController;

  RxList<AttachmentData> selectedResult = RxList<AttachmentData>();

  Future<List<AttachmentData>> onSubmit();

  void onCloseTab();

  Future<void> onClearSelectedResult();

  Future<void> onBack();

  void onHeaderVerticalDragUpdate(DragUpdateDetails details);

  Future<void> onHeaderVerticalDragEnd(DragEndDetails details);
}
