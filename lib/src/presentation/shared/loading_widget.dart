import 'package:flutter/material.dart';

import '../../../core/constants/ui_constant.dart';

class LoadingWidget extends StatelessWidget {
  final String message;
  const LoadingWidget({Key? key, this.message = "Đang tải"}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const CircularProgressIndicator(),
          const SizedBox(
            height: 10,
          ),
          Text(
            message,
            style: kTheme.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
