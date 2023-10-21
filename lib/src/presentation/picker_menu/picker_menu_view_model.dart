import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/core.dart';
import '../../domain/enums/private/picker_tab_status.dart';
import '../@base/tab_picker_controller.dart';
import '../file_picker/file_picker_view.dart';
import '../media_picker/media_picker_view.dart';
import '../location_picker/location_picker_view.dart';

class PickerMenuViewModel {
  final RxList<TabViewModel> tabs = <TabViewModel>[].obs;
  final Rx<TabViewModel> selectedTab =
      Rx<TabViewModel>(TabViewModel(attachmentType: AttachmentType.media));
  final RxList<AttachmentData> selectedAttachment = RxList<AttachmentData>();
  final Rx<PickerTabStatus> status = Rx<PickerTabStatus>(PickerTabStatus.empty);
  final Rxn<String> caption = Rxn<String>(null);

  set setCaption(String caption) {
    this.caption.call(caption);
  }

  set setStatus(PickerTabStatus status) {
    this.status.call(status);
  }

  set setSelectedTab(TabViewModel tab) {
    selectedTab.call(tab);
    tabs.call(tabs.map((e) {
      if (e.attachmentType == tab.attachmentType) {
        return TabViewModel.selected(attachmentType: e.attachmentType);
      } else {
        return TabViewModel(attachmentType: e.attachmentType);
      }
    }).toList());
  }

  set setTabs(List<TabViewModel> tabs) {
    this.tabs.clear();
    this.tabs.addAll(tabs);
  }

  set setSelectedAttachment(RxList<AttachmentData> attachment) {
    selectedAttachment.call(attachment);
  }
}

class TabViewModel {
  final AttachmentType attachmentType;
  final String title;
  final Icon icon;
  final bool isSelected;
  final TabPickerController? controller;
  TabViewModel({
    required this.attachmentType,
    this.controller,
  })  : title = attachmentType.title,
        icon = Icon(attachmentType.icon),
        isSelected = false;

  TabViewModel.selected({
    required this.attachmentType,
    this.controller,
  })  : title = attachmentType.title,
        icon = Icon(attachmentType.icon),
        isSelected = true;

  Widget build({ScrollController? scrollController}) {
    switch (attachmentType) {
      case AttachmentType.media:
        return MediaPickerView(scrollController: scrollController!);
      case AttachmentType.file:
        return FilePickerView(scrollController: scrollController!);
      case AttachmentType.location:
        return LocationPickerView(scrollController: scrollController!);
    }
  }

  get color {
    switch (attachmentType) {
      case AttachmentType.media:
        return kTheme.colorScheme.primary.withGreen(50);
      case AttachmentType.file:
        return Colors.amber;
      case AttachmentType.location:
        return Colors.redAccent;
      default:
        return kTheme.colorScheme.primary;
    }
  }
}
