import 'package:flutter/material.dart';

class FadeScaleTransitionWrapper extends StatefulWidget {
  final Widget child;
  final Duration? duration;
  const FadeScaleTransitionWrapper({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 240),
  });

  @override
  State<FadeScaleTransitionWrapper> createState() => _FadeScaleTransitionWrapperState();
}

class _FadeScaleTransitionWrapperState extends State<FadeScaleTransitionWrapper> with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: widget.duration ?? const Duration(milliseconds: 1000),
    vsync: this,
  )..animateTo(1.0);
  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.fastOutSlowIn,
  );
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animation,
      child: ScaleTransition(
        scale: _animation,
        child: widget.child,
      ),
    );
  }
}
