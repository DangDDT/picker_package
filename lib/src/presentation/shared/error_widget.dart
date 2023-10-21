import 'package:core_picker/core/core.dart';
import 'package:flutter/material.dart';

class ErrorOrEmptyWidget extends StatelessWidget {
  final String message;
  final String? content;
  final VoidCallback? callBack;
  const ErrorOrEmptyWidget({
    Key? key,
    this.message = "Không có dữ liệu",
    this.content,
    this.callBack,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: InkWell(
        onTap: callBack,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              size: 50,
              color: Colors.grey,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(message,
                style: kTheme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                )),
            if (content != null)
              const SizedBox(
                height: 10,
              ),
            if (content != null)
              Text(
                content!,
                style: kTheme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
