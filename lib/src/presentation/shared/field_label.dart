import 'package:flutter/material.dart';

class FieldLabel extends StatelessWidget {
  const FieldLabel(
    this.text, {
    super.key,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.bodySmall?.copyWith(
            fontWeight: FontWeight.w400,
            color: Theme.of(context).hintColor,
          ),
    );
  }
}
