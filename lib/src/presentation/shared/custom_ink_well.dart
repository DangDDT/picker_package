import 'package:flutter/material.dart';

class CustomInkwell extends StatefulWidget {
  const CustomInkwell({
    super.key,
    required this.child,
    required this.onTap,
  });

  final Widget child;
  final Function() onTap;

  @override
  State<CustomInkwell> createState() => _CustomInkwellState();
}

class _CustomInkwellState extends State<CustomInkwell> {
  bool isPressed = false;

  void _togglePressed(bool value) {
    setState(() {
      isPressed = value;
    });
  }

  void _onTap() async {
    await widget.onTap.call();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 100),
      opacity: isPressed ? .5 : 1,
      child: GestureDetector(
        onTap: _onTap,
        onTapDown: (_) => _togglePressed(true),
        onTapUp: (_) => _togglePressed(false),
        onPanEnd: (_) => _togglePressed(false),
        child: widget.child,
      ),
    );
  }
}
