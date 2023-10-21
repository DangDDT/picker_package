import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vif_flutter_base/vif_flutter_base.dart';

class VIFToast extends VIFToastDataSource {
  @override
  void show(BuildContext context, String message,
      {VIFToastCategories? categories}) {
    // Flushbar<dynamic>(
    //   duration: const Duration(seconds: 3),
    //   margin: const EdgeInsets.all(10),
    //   reverseAnimationCurve: Curves.fastLinearToSlowEaseIn,
    //   borderRadius: BorderRadius.circular(kDefaultBorderRadius),
    //   backgroundColor: _categorieToColor(
    //     categories ?? VIFToastCategories.none,
    //   ),
    //   icon: Icon(
    //     _categorieToIconData(
    //       categories ?? VIFToastCategories.none,
    //     ),
    //     color: Colors.white,
    //   ),
    //   message: message,
    //   titleColor: Colors.white,
    // ).show(context);
    final screenSize = Get.size;

    final iconSize = (screenSize.width > 800) ? 32.0 : 20.0;

    final foregroundColor = _categorieToColor(
      categories ?? VIFToastCategories.none,
    );
    Get
      ..closeCurrentSnackbar()
      ..showSnackbar(
        GetSnackBar(
          backgroundColor: foregroundColor,
          borderRadius: 12,
          duration: const Duration(seconds: 2),
          animationDuration: const Duration(milliseconds: 510),
          margin: const EdgeInsets.all(12),
          icon: Icon(
            _categorieToIconData(categories ?? VIFToastCategories.none),
            size: iconSize,
            color: Colors.white,
          ),
          message: message,
        ),
      );
  }

  Color _categorieToColor(VIFToastCategories categorie) {
    switch (categorie) {
      case VIFToastCategories.warning:
        return Colors.amber;
      case VIFToastCategories.info:
        return Colors.black;
      case VIFToastCategories.success:
        return Colors.green;
      case VIFToastCategories.error:
        return Colors.red;
      case VIFToastCategories.none:
        return Colors.black87;
    }
  }

  IconData _categorieToIconData(VIFToastCategories categorie) {
    switch (categorie) {
      case VIFToastCategories.warning:
        return Icons.warning_amber_rounded;
      case VIFToastCategories.info:
        return Icons.info_outline_rounded;
      case VIFToastCategories.success:
        return Icons.check_circle_outline_rounded;
      case VIFToastCategories.error:
        return Icons.error_outline_rounded;
      case VIFToastCategories.none:
        return Icons.info_outline_rounded;
    }
  }
}
