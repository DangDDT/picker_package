import 'package:flutter/material.dart';

class FadeScaleSwitcherWrapper extends StatelessWidget {
  final Widget child;
  final Duration duration;
  const FadeScaleSwitcherWrapper({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 240),
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: duration,
      transitionBuilder: (child, animation) {
        return FadeTransition(
          opacity: animation,
          child: ScaleTransition(
            scale: animation,
            child: child,
          ),
        );
      },
      child: child,
    );
  }
}
