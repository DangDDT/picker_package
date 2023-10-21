// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension DateTimeExt on DateTime {
  Duration differenceToday() => difference(DateTime.now());

  String toDateReadable() => DateFormat('dd/MM/yyyy').format(this);

  String toHourMinute() => DateFormat.Hm().format(this);

  String toReadable() => DateFormat('dd/MM/yyyy').format(this);

  String toReadableDueDateString() {
    final toDayWithTime = DateTime.now();
    final toDay = DateTime(
      toDayWithTime.year,
      toDayWithTime.month,
      toDayWithTime.day,
    );

    final data = DateTime(
      year,
      month,
      day,
    );

    if (isSameDate(toDay)) {
      return 'Hôm nay';
    }
    final dateBetween = data.difference(toDay);
    if (dateBetween.inDays.abs() <= 7) {
      if (dateBetween.inDays >= 0) {
        return 'Còn ${dateBetween.inDays.abs().toString()} ngày';
      }
      return 'Quá hạn ${dateBetween.inDays.abs().toString()} ngày';
    }
    return DateFormat('dd/MM/yyyy').format(this);
  }

  bool isSameDate(DateTime other) {
    return year == other.year && month == other.month && day == other.day;
  }

  toDueDateCount() {
    final toDayWithTime = DateTime.now();
    final toDay = DateTime(toDayWithTime.year, toDayWithTime.month, toDayWithTime.day);

    final data = DateTime(year, month, day);

    if (isSameDate(toDay)) {
      return 'Hôm nay';
    }

    if (isSameDate(toDay)) {
      return 'Hôm nay';
    }

    final dateBetween = data.difference(toDay);

    if (dateBetween.inDays > 0) {
      return 'Còn ${dateBetween.inDays.abs().toString()} ngày';
    }

    return 'Quá hạn ${dateBetween.inDays.abs().toString()} ngày';
  }

  String toFullString() {
    return '${DateFormat.Hm().format(this)} ${DateFormat('dd/MM/yyyy').format(this)}';
  }

  String toRecentlyString() {
    final now = DateTime.now();
    final between = difference(now);
    if (between.inMinutes.abs() < 1) {
      return 'Vừa xong';
    }
    //Case lower than 1 hour.
    if (between.inMinutes.abs() < 60) {
      return '${between.inMinutes.abs()} phút';
    }
    if (between.inHours.abs() < 24) {
      return '${between.inHours.abs()} giờ';
    }
    if (between.inDays.abs() < 7) {
      return '${between.inDays.abs()} ngày';
    }
    return 'Ngày ${DateFormat('dd/MM/yyyy').format(this)} lúc ${DateFormat.Hm().format(this)}';
  }

  String toRecentlyStringFull() {
    final now = DateTime.now();
    final between = difference(now);
    if (between.inMinutes.abs() < 1) {
      return 'Vừa xong';
    }
    //Case lower than 1 hour.
    if (between.inMinutes.abs() < 60) {
      return '${between.inMinutes.abs()} phút trước';
    }
    if (between.inHours.abs() < 24) {
      return '${between.inHours.abs()} giờ trước';
    }

    if (between.inDays.abs() < 2) {
      final time = DateFormat.Hm().format(this);
      return 'Hôm qua lúc $time';
    }
    if (between.inDays.abs() < 7) {
      final dayInWeek = DateFormat.EEEE('vi').format(this);
      final time = DateFormat.Hm().format(this);
      return '$dayInWeek lúc $time';
    }
    return 'Ngày ${DateFormat('dd/MM/yyyy').format(this)} lúc ${DateFormat.Hm().format(this)}';
  }

  Color? getColorFromDueDate(ThemeData theme) {
    final days = differenceToday().inDays;
    if (days < 0) {
      return Colors.red.shade900;
    }
    return theme.hintColor;
  }

  /// shorted function to compare two DateTime, return 1 if this > other, -1 if this < other, 0 if this == other
  int compareDateTime(DateTime other) {
    if (isAfter(other)) {
      return 1;
    } else if (isBefore(other)) {
      return -1;
    } else {
      return 0;
    }
  }
}
