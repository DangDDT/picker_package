import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:vif_previewer/previewer.dart';

import '../../../core/core.dart';
import 'preview_controller.dart';

class PreviewView extends GetView<PreviewController> {
  const PreviewView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: () async {
          final isPop = await controller.onBack();
          return isPop;
        },
        child: KeyboardDismisser(
          child: Scaffold(
            backgroundColor: Colors.black,
            body: Stack(
              children: [
                Positioned.fill(
                  child: IgnorePointer(
                    ignoring: controller.isShowSubmitBar,
                    child: MediaPreviewPageView(
                      controller: controller.mediaPreviewController,
                      physics:
                          controller.physic ?? const BouncingScrollPhysics(),
                    ),
                  ),
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  left: 0,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.black.withOpacity(0.8),
                          Colors.black.withOpacity(0.6),
                          Colors.black.withOpacity(0.4),
                          Colors.black.withOpacity(0.2),
                          Colors.black.withOpacity(0.0),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                    child: const _TopActionBar(),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.black.withOpacity(0.8),
                          Colors.black.withOpacity(0.6),
                          Colors.black.withOpacity(0.4),
                          Colors.black.withOpacity(0.2),
                          Colors.black.withOpacity(0.0),
                        ],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                      ),
                    ),
                    child: const _BottomActionBar(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _TopActionBar extends StatelessWidget {
  const _TopActionBar();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.min,
      children: const [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: _BackwardButton(),
        ),
      ],
    );
  }
}

class _BackwardButton extends GetView<PreviewController> {
  const _BackwardButton();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: const Icon(
        Icons.close,
        color: Colors.white,
      ),
      onTap: () async {
        final isPop = await controller.onBack();
        if (isPop) {
          Get.back();
        }
      },
    );
  }
}

class _BottomActionBar extends GetView<PreviewController> {
  const _BottomActionBar();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (controller.isShowSubmitBar) const _SubmitBar(),
        VideoControlUI(
          controller: controller.mediaPreviewController,
          foregroundColor: Colors.white,
        ),
      ],
    );
  }
}

class _CaptionArea extends GetView<PreviewController> {
  const _CaptionArea();

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.multiline,
      maxLines: 5,
      minLines: 1,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
        hintText: controller
                .config.mediaPickerOption?.captionFieldConfig.captionHint ??
            DefaultPickerConstants.defaultCaption,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        hintStyle: kTheme.textTheme.titleSmall?.copyWith(
          color: Colors.white30.computeLuminance() > 0.5
              ? Colors.white70
              : Colors.black12,
        ),
        filled: true,
        fillColor: Colors.white12.computeLuminance() > 0.5
            ? Colors.black12
            : Colors.white24,
      ),
      style: kTheme.textTheme.titleSmall?.copyWith(
        color: Colors.white,
      ),
      onChanged: controller.onChangeCaption,
    );
  }
}

class _SubmitBar extends GetView<PreviewController> {
  const _SubmitBar();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: (controller.config.mediaPickerOption?.isUseCaptionField ??
                    false)
                ? const _CaptionArea()
                : const SizedBox(),
          ),
          kGapW8,
          const _SubmitButton(),
        ],
      ),
    );
  }
}

class _SubmitButton extends GetView<PreviewController> {
  const _SubmitButton();

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 240),
      curve: Curves.easeInOut,
      child: IconButton(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: kTheme.colorScheme.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        icon: Icon(
          controller.config.submitButtonIcon,
          color: kTheme.colorScheme.onPrimary,
        ),
        onPressed: controller.onSubmit,
      ),
    );
  }
}
