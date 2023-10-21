import 'package:flutter/material.dart';

class FadeTransitionWrapper extends StatefulWidget {
  const FadeTransitionWrapper({
    Key? key,
    required this.child,
    this.duration = const Duration(milliseconds: 1000),
  }) : super(key: key);
  final Duration duration;
  final Widget child;

  @override
  State<FadeTransitionWrapper> createState() => _FadeTransitionWrapperState();
}

class _FadeTransitionWrapperState extends State<FadeTransitionWrapper> with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: widget.duration,
    vsync: this,
  )..animateTo(1.0);
  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.easeIn,
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
      child: widget.child,
    );
  }
}
