import 'dart:async';

import 'package:flutter/material.dart';
import 'package:vif_flutter_base/vif_flutter_base.dart';

class VIFPicker extends VIFDateTimePickerDataSource {
  @override
  FutureOr<DateTime?> pickDate(
    BuildContext context, {
    DateTime? minDate,
    DateTime? maxDate,
    DateTime? initialDate,
  }) {
    var firstDate = minDate;
    var lastDate = maxDate;
    if (minDate == null) {
      firstDate = DateTime(DateTime.now().year - 5);
    }
    if (maxDate == null) {
      lastDate = DateTime(DateTime.now().year + 1);
    }
    return showDatePicker(
      context: context,
      initialDate: initialDate ?? DateTime.now(),
      firstDate: firstDate!,
      lastDate: lastDate!,
      locale: const Locale('vi', 'VI'),
      builder: (context, child) => Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(primary: Theme.of(context).primaryColor),
            buttonTheme: const ButtonThemeData(textTheme: ButtonTextTheme.primary),
          ),
          child: child!),
    );
  }

  @override
  FutureOr<TimeOfDay?> pickTime(
    BuildContext context, {
    TimeOfDay? initialDate,
  }) {
    return showTimePicker(
      context: context,
      initialTime: initialDate ?? TimeOfDay.now(),
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
          child: Localizations.override(
            context: context,
            locale: const Locale('vi', 'VI'),
            child: Theme(
              data: ThemeData.light().copyWith(
                colorScheme: ColorScheme.light(primary: Theme.of(context).primaryColor),
                buttonTheme: const ButtonThemeData(textTheme: ButtonTextTheme.primary),
              ),
              child: child!,
            ),
          ),
        );
      },
    );
  }

  @override
  FutureOr<TimeOfDay?> pickDateRange(BuildContext context, {TimeOfDay? initialDate}) {
    // TODO: implement pickDateRange
    throw UnimplementedError();
  }
}
