import 'package:animations/animations.dart';
import 'package:flutter/material.dart';

class FadeThroughTransitionWrapper extends StatefulWidget {
  final Duration? duration;
  final Widget child;
  const FadeThroughTransitionWrapper({super.key, this.duration, required this.child});

  @override
  State<FadeThroughTransitionWrapper> createState() => _FadeThroughTransitionWrapperState();
}

class _FadeThroughTransitionWrapperState extends State<FadeThroughTransitionWrapper>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: widget.duration ?? const Duration(milliseconds: 1000),
    vsync: this,
  )..animateTo(1.0);
  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.fastOutSlowIn,
  );
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeThroughTransition(
      animation: _animation,
      secondaryAnimation: ReverseAnimation(_animation),
      fillColor: Colors.transparent,
      child: widget.child,
    );
  }
}
