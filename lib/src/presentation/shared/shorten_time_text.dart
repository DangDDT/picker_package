import 'dart:async';

import 'package:core_picker/core/core.dart';
import 'package:flutter/material.dart';

class ShortenTimeText extends StatefulWidget {
  const ShortenTimeText(
    this.time, {
    super.key,
    this.style,
    this.autoCollapseDuration = const Duration(seconds: 8),
  });

  final DateTime time;
  final TextStyle? style;
  final Duration autoCollapseDuration;

  @override
  State<ShortenTimeText> createState() => _AnimatedShortedTimeStampState();
}

class _AnimatedShortedTimeStampState extends State<ShortenTimeText> {
  bool isCollapsed = true;
  Timer? collapsedTimer;
  Timer? refreshTimer;

  void toggleCollapsed() {
    if (isCollapsed) {
      setState(() {
        isCollapsed = false;
      });
      setState(
        () => collapsedTimer = Timer(widget.autoCollapseDuration, () {
          if (mounted) {
            setState(() {
              isCollapsed = true;
            });
          }
        }),
      );
    }
  }

  @override
  void initState() {
    // refreshTimer = Timer.periodic(
    //   const Duration(minutes: 1),
    //   (Timer t) => setState(() {}),
    // );
    super.initState();
  }

  @override
  void dispose() {
    // refreshTimer?.cancel();
    // refreshTimer = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: toggleCollapsed,
      child: AnimatedSize(
        alignment: Alignment.bottomLeft,
        duration: const Duration(milliseconds: 210),
        child: isCollapsed
            ? Text(
                widget.time.toRecentlyString(),
                style: widget.style,
              )
            : Text(
                widget.time.toRecentlyStringFull(),
                style: widget.style,
              ),
      ),
    );
  }
}
