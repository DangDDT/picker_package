import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/core.dart';

class CancelConfirmDialog extends StatelessWidget {
  const CancelConfirmDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(LanguageKeys.confirmCancelDialogTitle.tr),
      actions: [
        TextButton(
          onPressed: () {
            Get.back(result: false);
          },
          child: Text(LanguageKeys.no.tr, textAlign: TextAlign.center),
        ),
        TextButton(
          onPressed: () {
            Get.back(result: true);
          },
          child: Text(LanguageKeys.yes.tr, textAlign: TextAlign.center),
        ),
      ],
    );
  }
}
