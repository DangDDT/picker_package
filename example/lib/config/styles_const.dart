//Color

import 'dart:collection';

import 'package:flutter/material.dart';

//Light Theme
const kPrimaryLightColor = Color(0xFF54B435);
const kDividerColor = Color(0xFFF4F6FA);
const kTextFieldLightColor = Color(0xFFeff3f4);
const kCardLightColor = Color(0xFFf5f8fe);
const kBackgroundLight = Color(0xFFebf1f1);

// Text Colors
const kTextColorPrimaryLight = Color(0xFF030F2D);
const kTextColor = Colors.black;
const kTextColorBody = Colors.black87;
const kTextColorGrey = Color(0xFFB6B5BA);

//Secondary Colors
const kSecondaryRed = Color(0xFFeb717c);
const kSecondaryRedLight = Color.fromRGBO(247, 113, 129, 1);
const kSecondaryBlue = Color(0xFF006DB8);
const kSecondaryBlueLight = Color(0xFF0090A0);
const kSecondaryGreen = Color(0xFF00AB5D);
const kSecondaryGreenLight = Color.fromRGBO(130, 223, 107, 1);
const kSecondaryYellow = Color(0xFFDE9E54);

//
const kDefaultBorderRadius = 12.0;
const kShadowColor = Color.fromRGBO(149, 157, 165, 0.2);
const kDefaultBoxShadow = BoxShadow(
  color: kShadowColor,
  offset: Offset(0, 8),
  blurRadius: 24,
);
List<Shadow> outlinedText({
  double strokeWidth = 2,
  Color strokeColor = Colors.black,
  int precision = 5,
}) {
  final result = HashSet<Shadow>();
  for (var x = 1; x < strokeWidth + precision; x++) {
    for (var y = 1; y < strokeWidth + precision; y++) {
      final offsetX = x.toDouble();
      final offsetY = y.toDouble();
      result
        ..add(
          Shadow(
            offset: Offset(-strokeWidth / offsetX, -strokeWidth / offsetY),
            color: strokeColor,
          ),
        )
        ..add(
          Shadow(
            offset: Offset(-strokeWidth / offsetX, strokeWidth / offsetY),
            color: strokeColor,
          ),
        )
        ..add(
          Shadow(
            offset: Offset(strokeWidth / offsetX, -strokeWidth / offsetY),
            color: strokeColor,
          ),
        )
        ..add(
          Shadow(
            offset: Offset(strokeWidth / offsetX, strokeWidth / offsetY),
            color: strokeColor,
          ),
        );
    }
  }
  return result.toList();
}

const kGapH4 = SizedBox(height: 4);
const kGapH8 = SizedBox(height: 8);
const kGapH12 = SizedBox(height: 12);
const kGapH24 = SizedBox(height: 24);

const kGapW4 = SizedBox(width: 4);
const kGapW8 = SizedBox(width: 8);
const kGapW12 = SizedBox(width: 12);
const kGapW24 = SizedBox(width: 24);
