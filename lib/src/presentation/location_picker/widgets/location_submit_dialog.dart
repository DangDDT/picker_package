import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/core.dart';
import '../../../domain/models/location_return_value.dart';
import '../location_picker_controller.dart';
import 'my_location_map.dart';

class LocationSubmitDialog extends GetView<LocationPickerController> {
  const LocationSubmitDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: kTheme.colorScheme.background,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      title: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // LottieBuilder.asset(
          //   Assets.core_picker$assets_icons_97425_mapa_json,
          //   height: 200,
          //   fit: BoxFit.contain,
          //   reverse: true,
          // ),
          SizedBox(
            height: Get.height * 0.25,
            width: Get.width,
            child: const ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(4)),
              child: MyLocationMap(),
            ),
          ),
          kGapH16,
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              LanguageKeys.confirmLocationDialogTitle.tr,
              style: kTheme.textTheme.titleMedium,
            ),
          ),
        ],
      ),
      content: const SingleChildScrollView(
        child: _CaptionArea(),
      ),
      actions: const [
        _CancelButton(),
        _SubmitButton(),
      ],
    );
  }
}

class _CaptionArea extends GetView<LocationPickerController> {
  const _CaptionArea();

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofocus: true,
      keyboardType: TextInputType.multiline,
      maxLines: 5,
      minLines: 1,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(
          vertical: 8,
        ),
        hintText: controller.config.locationPickerOption?.captionFieldConfig.captionHint ??
            DefaultPickerConstants.defaultCaption,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
        hintStyle: kTheme.textTheme.titleSmall?.copyWith(
          color: kTheme.colorScheme.onBackground.withOpacity(0.6),
        ),
        fillColor: Colors.black12.withOpacity(0.05),
      ),
      style: kTheme.textTheme.titleSmall?.copyWith(
        color: kTheme.colorScheme.onBackground,
      ),
      onChanged: controller.onChangeCaption,
    );
  }
}

class _CancelButton extends GetView<LocationPickerController> {
  const _CancelButton();

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => Get.back(
        result: LocationReturnValue(isBackToRoot: false),
      ),
      child: Text(
        LanguageKeys.cancel.tr,
        style: kTheme.textTheme.titleSmall?.copyWith(
          color: kTheme.colorScheme.onBackground.withOpacity(0.6),
        ),
      ),
    );
  }
}

class _SubmitButton extends GetView<LocationPickerController> {
  const _SubmitButton();

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => Get.back(
        result: LocationReturnValue(
          isBackToRoot: true,
        ),
      ),
      child: Text(
        LanguageKeys.confirm.tr,
        style: kTheme.textTheme.titleSmall?.copyWith(
          color: kTheme.colorScheme.primary,
        ),
      ),
    );
  }
}
