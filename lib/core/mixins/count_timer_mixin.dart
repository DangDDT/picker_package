import 'dart:async';

import 'package:get/get.dart';

mixin CountTimeMixin {
  final countTimeWorker = _CountTime();
}

class _CountTime {
  Timer? _countTimer;
  Duration? initialDuration;
  Rx<Duration> currentDuration = Rx<Duration>(Duration.zero);

  void setTimer(Duration duration) {
    initialDuration = duration;
    restartTimer();
  }

  ///Start timer
  void startTimer() {
    _countTimer = Timer.periodic(
      const Duration(seconds: 1),
      (_) => _setCountDown(),
    );
  }

  ///Stop timer and restart to initial duration.
  void restartTimer() {
    stopTimer();
    resetTimer();
    startTimer();
  }

  ///Stop timer
  void stopTimer() {
    _countTimer?.cancel();
  }

  ///Stop timer and reset to initial duration
  void resetTimer() {
    stopTimer();
    currentDuration.call(Duration.zero);
  }

  void _setCountDown() {
    const addedSecondsBy = 1;
    final seconds = currentDuration.value.inSeconds + addedSecondsBy;
    if (seconds < 0) {
      _countTimer!.cancel();
    } else {
      currentDuration.call(Duration(seconds: seconds));
    }
  }

  void disposeTimer() {
    _countTimer!.cancel();
  }
}
