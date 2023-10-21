import 'package:flutter/material.dart';
import 'dart:math' as math;

class OverlayWrapper extends CustomPainter {
  OverlayWrapper({
    // required this.rectWidth,
    this.borderColor,
  });

  final Color? borderColor;
  // final double rectWidth;

  @override
  void paint(Canvas canvas, Size size) {
    final canvasRect = Offset.zero & size;
    final rect = Rect.fromCenter(
      center: canvasRect.center,
      width: canvasRect.width,
      height: canvasRect.height,
    );
    const radius = 0.0;
    const strokeWidth = 1.0;
    const extend = radius + 24.0;
    const arcSize = Size.fromRadius(radius);
    final rectWidth = size.width;

    canvas
      ..drawPath(
        Path()
          ..fillType = PathFillType.evenOdd
          ..addRRect(
            RRect.fromRectAndRadius(
              rect,
              const Radius.circular(radius),
            ).deflate(strokeWidth / 2),
          )
          ..addRect(canvasRect),
        Paint()..color = Colors.black26,
      )
      ..save()
      ..translate(rect.left, rect.top);
    final path = Path();
    for (var i = 0; i < 4; i++) {
      final l = i & 1 == 0;
      final t = i & 2 == 0;
      path
        ..moveTo(l ? 0 : rectWidth, t ? extend : rectWidth - extend)
        ..arcTo(
          Offset(
                l ? 0 : rectWidth - arcSize.width,
                t ? 0 : rectWidth - arcSize.width,
              ) &
              arcSize,
          l ? math.pi : math.pi * 2,
          l == t ? math.pi / 2 : -math.pi / 2,
          false,
        )
        ..lineTo(l ? extend : rectWidth - extend, t ? 0 : rectWidth);
    }
    canvas
      ..drawPath(
        path,
        Paint()
          ..color = (borderColor ?? Colors.white)
          ..strokeWidth = strokeWidth
          ..strokeCap = StrokeCap.round
          ..style = PaintingStyle.stroke,
      )
      ..restore();
  }

  @override
  bool shouldRepaint(OverlayWrapper oldDelegate) => false;
}
