import 'package:example/vif_base/vif_base.dart';
import 'package:flutter/material.dart';
import 'package:vif_flutter_base/vif_flutter_base.dart';

class VIFBaseWidgets extends VIFBaseWidgetsDataSource {
  @override
  VIFImageDataSource get image => VIFImage();

  @override
  Widget loadingScreen({String title = 'Đang tải'}) => Center(
        child: Column(
          children: [const CircularProgressIndicator(), Text(title)],
        ),
      );

  @override
  Widget loadingComponent({String title = 'Đang tải'}) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircularProgressIndicator(),
            // kGapH24,
            Text(title),
          ],
        ),
      );

  @override
  Widget noDataComponent({
    String title = 'Không có dữ liệu',
    String? content,
    Widget? image,
    VoidCallback? callBack,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(
          Icons.error_outline,
          size: 48,
          color: Colors.grey,
        ),
        const SizedBox(height: 8),
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          content ?? '',
          style: const TextStyle(
            fontSize: 14,
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: 8),
        if (callBack != null)
          ElevatedButton(
            onPressed: callBack,
            child: const Text(
              'Thử lại',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
          ),
      ],
    );
  }

  @override
  Widget noDataScreen({
    String title = 'Không có dữ liệu',
    String? content,
    Widget? image,
    VoidCallback? callBack,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(
          Icons.error_outline,
          size: 48,
          color: Colors.grey,
        ),
        const SizedBox(height: 8),
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          content ?? '',
          style: const TextStyle(
            fontSize: 14,
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: 8),
        if (callBack != null)
          ElevatedButton(
            onPressed: callBack,
            child: const Text(
              'Thử lại',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
          ),
      ],
    );
  }

  @override
  Widget systemErrorComponent({
    String title = 'Lỗi hệ thống',
    String? content,
    Widget? image,
    VoidCallback? callBack,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(
          Icons.error_outline,
          size: 48,
          color: Colors.grey,
        ),
        const SizedBox(height: 8),
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          content ?? '',
          style: const TextStyle(
            fontSize: 14,
            color: Colors.grey,
          ),
        ),
        if (callBack != null)
          ElevatedButton(
            onPressed: callBack,
            child: const Text(
              'Thử lại',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
          ),
      ],
    );
  }

  @override
  Widget systemErrorScreen({
    String title = 'Lỗi hệ thống',
    String? content,
    Widget? image,
    VoidCallback? callBack,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(
          Icons.error_outline,
          size: 48,
          color: Colors.grey,
        ),
        const SizedBox(height: 8),
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          content ?? '',
          style: const TextStyle(
            fontSize: 14,
            color: Colors.grey,
          ),
        ),
        if (callBack != null)
          ElevatedButton(
            onPressed: callBack,
            child: const Text(
              'Thử lại',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
          ),
      ],
    );
  }
}
