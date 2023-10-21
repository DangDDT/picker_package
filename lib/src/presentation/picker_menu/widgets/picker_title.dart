import 'package:flutter/widgets.dart';

import '../../../../core/core.dart';

class PickerTitle extends StatelessWidget {
  final String title;
  const PickerTitle({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        title,
        style: kTheme.textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.bold,
          color: kTheme.colorScheme.primary,
        ),
      ),
    );
  }
}
