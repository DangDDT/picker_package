import 'package:core_picker/core/core.dart';
import 'package:core_picker/src/presentation/shared/fade_transition_wrapper.dart';
import 'package:core_picker/src/presentation/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../domain/domain.dart';
import 'picker_menu_controller.dart';
import 'picker_menu_view_model.dart';

const int _kRemoveTabBarAnchor = 1;
const double kDraggableScrollableSheetMaxChildSize = .9;
const double kDraggableScrollableSheetInitialChildSize = .7;
const double kDraggableScrollableSheetMinChildSize = .5;
const double _kViewInsetsBottomConstant = 1000;

class PickerMenuView extends StatelessWidget {
  const PickerMenuView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: PickerMenuController(),
      builder: (controller) => WillPopScope(
        onWillPop: () async {
          final isPop = await controller.onCloseTab();
          return isPop;
        },
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () async {
            final isPop = await controller.onCloseTab();
            if (isPop) Get.back();
          },
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: NotificationListener<DraggableScrollableNotification>(
              onNotification: (notification) {
                if (notification.extent <=
                    kDraggableScrollableSheetMinChildSize) {
                  controller.onCloseTab().then((isPop) {
                    if (isPop) Get.back();
                  });
                }
                return true;
              },
              child: DraggableScrollableSheet(
                maxChildSize: kDraggableScrollableSheetMaxChildSize,
                initialChildSize: kDraggableScrollableSheetInitialChildSize +
                    Get.mediaQuery.viewInsets.bottom /
                        _kViewInsetsBottomConstant,
                minChildSize: kDraggableScrollableSheetMinChildSize,
                snapSizes: const [
                  kDraggableScrollableSheetMinChildSize,
                  kDraggableScrollableSheetInitialChildSize,
                  kDraggableScrollableSheetMaxChildSize,
                ],
                snap: true,
                controller: controller.dragScrollController,
                builder: (context, scrollController) {
                  controller.scrollController = scrollController;
                  return Container(
                    padding:
                        EdgeInsets.only(bottom: Get.mediaQuery.padding.bottom),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12),
                        topRight: Radius.circular(12),
                      ),
                    ),
                    child: const Stack(
                      children: [
                        Positioned.fill(
                          child: _TabBarView(),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: _MenuFooter(),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _MenuFooter extends GetView<PickerMenuController> {
  const _MenuFooter();

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
        transitionBuilder: (child, animation) {
          return FadeTransition(
            key: ValueKey(controller.pickerMenuModel.status.value),
            opacity: animation,
            child: SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0, 1),
                end: const Offset(0, 0),
              ).animate(animation),
              child: child,
            ),
          );
        },
        reverseDuration: const Duration(milliseconds: 210),
        duration: const Duration(milliseconds: 210),
        child: Obx(() {
          switch (controller.pickerMenuModel.status.value) {
            case PickerTabStatus.empty:
              return const _TabBar();
            case PickerTabStatus.readyToSubmit:
              return Container(
                padding: GetPlatform.isAndroid
                    ? const EdgeInsets.all(8)
                    : const EdgeInsets.only(
                        left: 8, right: 8, bottom: 8, top: 8),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 4,
                      offset: Offset(0, -2),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (controller.isShowCaptionField)
                      const _SelectCountWhenCaption(),
                    const _SubmitBar(),
                  ],
                ),
              );
          }
        }));
  }
}

class _SelectCountWhenCaption extends GetView<PickerMenuController> {
  const _SelectCountWhenCaption();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Padding(
        padding: const EdgeInsets.only(right: 10.0),
        child: Row(
          children: [
            kGapW4,
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
              child: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: '${LanguageKeys.selected.tr}: ',
                      style: kTheme.textTheme.titleSmall?.copyWith(
                        color: kTheme.colorScheme.onBackground,
                      ),
                    ),
                    WidgetSpan(
                      alignment: PlaceholderAlignment.middle,
                      child: FadeSlideTransition(
                        duration: const Duration(milliseconds: 210),
                        key: ValueKey(controller
                            .pickerMenuModel.selectedAttachment.length),
                        child: Text(
                          '${controller.pickerMenuModel.selectedAttachment.length} ',
                          style: kTheme.textTheme.titleSmall?.copyWith(
                            color: kTheme.colorScheme.primary,
                          ),
                        ),
                      ),
                    ),
                    TextSpan(
                      text: controller.countUnit,
                      style: kTheme.textTheme.titleSmall?.copyWith(
                        color: kTheme.colorScheme.onBackground,
                      ),
                    )
                  ],
                ),
              ),
            ),
            kGapW4,
            GestureDetector(
              onTap: controller.onClearSelected,
              child: Center(
                child: Text(
                  LanguageKeys.unchecked.tr,
                  style: kTheme.textTheme.labelMedium?.copyWith(
                    color: Colors.red,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}

class _TabBarView extends GetView<PickerMenuController> {
  // ignore: unused_element
  const _TabBarView();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return FadeTransitionWrapper(
          duration: const Duration(milliseconds: 410),
          key: ValueKey(controller.pickerMenuModel.selectedTab.value),
          child: controller.pickerMenuModel.selectedTab.value
              .build(scrollController: controller.scrollController),
        );
      },
    );
  }
}

class _TabBar extends GetView<PickerMenuController> {
  const _TabBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (controller.config.categories.length > _kRemoveTabBarAnchor) {
      if (GetPlatform.isIOS) {
        return const _IosTabbar();
      } else if (GetPlatform.isAndroid) {
        return const _AndroidTabbar();
      } else {
        return SizedBox.shrink(
          key: UniqueKey(),
        );
      }
    } else {
      return SizedBox.shrink(
        key: UniqueKey(),
      );
    }
  }
}

class _AndroidTabbar extends GetView<PickerMenuController> {
  const _AndroidTabbar();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 8),
      key: UniqueKey(),
      decoration: BoxDecoration(
        color: kTheme.colorScheme.background,
      ),
      child: Obx(() {
        return TabBar(
          labelPadding: const EdgeInsets.symmetric(horizontal: 20),
          isScrollable: controller.pickerMenuModel.tabs.length > 3,
          controller: controller.tabController,
          indicatorSize: TabBarIndicatorSize.label,
          labelColor: kTheme.primaryColor,
          indicatorColor: Colors.transparent,
          unselectedLabelColor: kTheme.disabledColor,
          tabs: controller.pickerMenuModel.tabs
              .map((e) => _AndroidTab(tab: e))
              .toList(),
        );
      }),
    );
  }
}

class _IosTabbar extends GetView<PickerMenuController> {
  const _IosTabbar();

  @override
  Widget build(BuildContext context) {
    return Container(
      key: UniqueKey(),
      decoration: BoxDecoration(
        color: kTheme.colorScheme.background,
      ),
      child: TabBar(
        controller: controller.tabController,
        indicator: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
        ),
        labelColor: kTheme.colorScheme.primary,
        unselectedLabelColor: kTheme.disabledColor,
        tabs: controller.pickerMenuModel.tabs
            .map((e) => _IosTab(tab: e))
            .toList(),
      ),
    );
  }
}

class _IosTab extends GetView<PickerMenuController> {
  final TabViewModel tab;
  const _IosTab({required this.tab});

  @override
  Widget build(BuildContext context) {
    return Tab(
      iconMargin: const EdgeInsets.only(bottom: 4),
      text: tab.title,
      icon: tab.icon,
    );
  }
}

class _AndroidTab extends GetView<PickerMenuController> {
  final TabViewModel tab;
  const _AndroidTab({required this.tab});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 410),
          child: Container(
            height: 60,
            width: 50,
            key: ValueKey(tab.isSelected),
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: tab.color,
            ),
            child: Container(
              padding: const EdgeInsets.all(6),
              decoration: tab.isSelected
                  ? BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: kTheme.colorScheme.background,
                        width: 2,
                      ),
                    )
                  : null,
              child: Icon(
                tab.icon.icon,
                size: 30,
                color: kTheme.canvasColor,
              ),
            ),
          ),
        ),
        kGapH4,
        Text(
          tab.title,
          style: kTheme.textTheme.bodySmall?.copyWith(
            color: tab.isSelected
                ? kTheme.colorScheme.primary
                : kTheme.disabledColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

class _SubmitBar extends GetView<PickerMenuController> {
  const _SubmitBar();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Row(
        children: [
          Expanded(
            child: (controller.isShowCaptionField)
                ? const _CaptionArea()
                : const _SelectedCount(),
          ),
          kGapW8,
          const _SubmitButton(),
        ],
      ),
    );
  }
}

class _CaptionArea extends GetView<PickerMenuController> {
  const _CaptionArea();

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: controller.captionFocusNode,
      keyboardType: TextInputType.multiline,
      maxLines: 5,
      minLines: 1,
      decoration: InputDecoration(
        isDense: true,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 8,
          vertical: 8,
        ),
        hintText: controller.captionHint,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        fillColor: Colors.black45,
        hintStyle: kTheme.textTheme.titleSmall?.copyWith(
          color: kTheme.colorScheme.onBackground.withOpacity(0.5),
        ),
      ),
      style: kTheme.textTheme.titleSmall?.copyWith(
        color: kTheme.colorScheme.onBackground,
      ),
      onChanged: controller.onChangeCaption,
    );
  }
}

class _SelectedCount extends GetView<PickerMenuController> {
  const _SelectedCount();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 240),
          curve: Curves.easeInOut,
          decoration: BoxDecoration(
            color: kTheme.colorScheme.surfaceVariant,
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: '${LanguageKeys.selected.tr}: ',
                      style: kTheme.textTheme.titleSmall?.copyWith(
                        color: kTheme.colorScheme.onBackground,
                      ),
                    ),
                    WidgetSpan(
                      alignment: PlaceholderAlignment.middle,
                      child: FadeSlideTransition(
                        duration: const Duration(milliseconds: 210),
                        key: ValueKey(controller
                            .pickerMenuModel.selectedAttachment.length),
                        child: Text(
                          '${controller.pickerMenuModel.selectedAttachment.length} ',
                          style: kTheme.textTheme.titleSmall?.copyWith(
                            color: kTheme.colorScheme.onBackground,
                          ),
                        ),
                      ),
                    ),
                    TextSpan(
                      text: controller.countUnit,
                      style: kTheme.textTheme.titleSmall?.copyWith(
                        color: kTheme.colorScheme.onBackground,
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: controller.onClearSelected,
                child: Icon(
                  Icons.clear,
                  color: kTheme.colorScheme.onBackground,
                  size: 16,
                ),
              )
            ],
          ),
        );
      },
    );
  }
}

class _SubmitButton extends GetView<PickerMenuController> {
  const _SubmitButton();

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 240),
      curve: Curves.easeInOut,
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: kTheme.colorScheme.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          visualDensity: VisualDensity.comfortable,
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
        ),
        icon: Icon(
          controller.config.submitButtonIcon,
          color: kTheme.colorScheme.onPrimary,
          size: 14,
        ),
        label: Text(
          controller.config.submitButtonTitle ??
              DefaultPickerConstants.defaultSubmitButtonTitle,
          style: kTheme.textTheme.labelMedium?.copyWith(
            color: kTheme.colorScheme.onPrimary,
          ),
        ),
        onPressed: controller.onSubmit,
      ),
    );
  }
}
