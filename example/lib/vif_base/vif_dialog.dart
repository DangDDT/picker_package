import 'dart:async';

import 'package:flutter/material.dart';
import 'package:vif_flutter_base/vif_flutter_base.dart';

class VIFDialog extends VIFDialogDataSource {
  @override
  Future<void> showAlert(BuildContext context, String title, String content, {String? cancelText = 'Đóng'}) {
    // TODO: implement showAlert
    throw UnimplementedError();
  }

  @override
  Future<bool?> showConfirm(BuildContext context, String title, String content,
      {String? okText = 'Đồng ý', String? cancelText = 'Đóng', Color? okColor, Color? cancelColor}) async {
    final result = await showGeneralDialog<bool>(
      context: context,
      pageBuilder: (context, animation, secondaryAnimation) =>
          AlertDialog(title: Text(title), content: Text(content), actions: [
        TextButton(onPressed: () => Navigator.of(context).pop(false), child: Text(cancelText!)),
        TextButton(onPressed: () => Navigator.of(context).pop(true), child: Text(okText!))
      ]),
    );
    return result ?? false;
  }

//   // @override
//   // Future<void> showAlertDialog(
//   //   BuildContext context,
//   //   String title,
//   //   String message, {
//   //   String? cancelText,
//   // }) async {
//   //   await showGeneralDialog(
//   //     context: context,
//   //     pageBuilder: (context, animation, secondaryAnimation) => RoundedDialog(
//   //       title: title,
//   //       content: message,
//   //       onSubmit: () => Navigator.of(context).pop(),
//   //     ),
//   //   );
//   // }
//   //
  // @override
  // Future<bool> showConfirmDialog(
  //   BuildContext context,
  //   String title,
  //   String message, {
  //   String? okText,
  //   String? cancelText,
  //   Color? submitColor,
  //   Color? cancelColor,
  // }) async {
  //   final result = await showGeneralDialog<bool>(
  //     context: context,
  //     pageBuilder: (context, animation, secondaryAnimation) => RoundedDialog(
  //       title: title,
  //       content: message,
  //       submitButtonColor: submitColor,
  //       submitLabel: okText,
  //       cancelLabel: cancelText,
  //       onCancel: () => Navigator.of(context).pop(false),
  //       onSubmit: () => Navigator.of(context).pop(true),
  //     ),
  //   );
  //   return result ?? false;
  // }

//   @override
//   Future<void> showAlert(
//     BuildContext context,
//     String title,
//     String content, {
//     String? cancelText,
//   }) =>
//       showGeneralDialog(
//         context: context,
//         pageBuilder: (context, animation, secondaryAnimation) => RoundedDialog(
//           title: title,
//           content: content,
//           onSubmit: () => Navigator.of(context).pop(),
//         ),
//       );

//   @override
//   Future<bool?> showConfirm(BuildContext context, String title, String content,
//           {String? okText, String? cancelText, Color? okColor, Color? cancelColor}) =>
//       showGeneralDialog<bool>(
//         context: context,
//         pageBuilder: (context, animation, secondaryAnimation) => RoundedDialog(
//           title: title,
//           content: content,
//           submitButtonColor: okColor,
//           submitLabel: okText,
//           cancelLabel: cancelText,
//           onCancel: () => Navigator.of(context).pop(false),
//           onSubmit: () => Navigator.of(context).pop(true),
//         ),
//       );
// }

// class RoundedDialog extends StatelessWidget {
//   const RoundedDialog({
//     required this.title,
//     required this.content,
//     required this.onSubmit,
//     this.onCancel,
//     this.cancelLabel,
//     this.submitLabel,
//     this.submitButtonColor,
//     this.cancelButtonColor,
//     super.key,
//   });
//   final String title;
//   final String content;
//   final String? submitLabel;
//   final String? cancelLabel;
//   final FutureOr<void> Function()? onCancel;
//   final FutureOr<void> Function() onSubmit;
//   final Color? submitButtonColor;
//   final Color? cancelButtonColor;
//   @override
//   Widget build(BuildContext context) {
//     return Dialog(
//       backgroundColor: Theme.of(context).scaffoldBackgroundColor,
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.all(
//           Radius.circular(kDefaultBorderRadius),
//         ),
//       ),
//       child: Padding(
//         padding: const EdgeInsets.all(20),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Text(
//               title,
//               textAlign: TextAlign.center,
//               style: Theme.of(context).textTheme.titleMedium,
//             ),
//             const SizedBox(height: 20),
//             Text(
//               content,
//               style: Theme.of(context).textTheme.bodyMedium,
//             ),
//             const SizedBox(
//               height: 20,
//             ),
//             VIFFlatButton(
//               onPressed: onSubmit,
//               label: submitLabel ?? 'Xác Nhận',
//               minWidth: double.infinity,
//               color: submitButtonColor,
//             ),
//             if (onCancel != null)
//               const SizedBox(
//                 height: 10,
//               ),
//             if (onCancel != null)
//               VIFFlatButton(
//                 onPressed: onCancel,
//                 label: cancelLabel ?? 'Huỷ',
//                 minWidth: double.infinity,
//                 color: cancelButtonColor ?? Colors.grey.shade400,
//               ),
//           ],
//         ),
//       ),
//     );
//   }
// }}
}
