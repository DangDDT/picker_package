import 'package:flutter/material.dart';

class Dragger extends StatelessWidget {
  const Dragger({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 5,
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}
