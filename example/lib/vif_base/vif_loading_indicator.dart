import 'package:flutter/material.dart';
import 'package:vif_flutter_base/vif_flutter_base.dart';

class VIFLoadingIndicator extends VIFLoadingIndicatorDataSource {
  @override
  Future<void> show(BuildContext context, {String title = "Đang tải"}) {
    return showGeneralDialog(
      barrierDismissible: false,
      context: context,
      useRootNavigator: true,
      pageBuilder: (context, _, __) => WillPopScope(
        onWillPop: () async => false,
        child: const Center(child: CircularProgressIndicator()),
      ),
    );
  }

  @override
  Future<void> dismiss(BuildContext context) async {
    Navigator.pop(context);
  }
}
