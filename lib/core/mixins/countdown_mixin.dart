import 'dart:async';

import 'package:get/get.dart';

mixin CountDownMixin {
  final countDownWorker = _CountDown();
}

class _CountDown {
  Timer? _countdownTimer;
  Duration? initialDuration;
  Rxn<Duration> currentDuration = Rxn<Duration>();

  void setTimer(Duration duration) {
    initialDuration = duration;
    restartTimer();
  }

  ///Start timer
  void startTimer() {
    _countdownTimer = Timer.periodic(
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
    _countdownTimer?.cancel();
  }

  ///Stop timer and reset to initial duration
  void resetTimer() {
    stopTimer();
    currentDuration.call(initialDuration);
  }

  void _setCountDown() {
    const reduceSecondsBy = 1;
    final seconds = currentDuration.value!.inSeconds - reduceSecondsBy;
    if (seconds < 0) {
      _countdownTimer!.cancel();
    } else {
      currentDuration.call(Duration(seconds: seconds));
    }
  }

  void disposeTimer() {
    _countdownTimer!.cancel();
  }
}
