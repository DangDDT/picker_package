extension IntX on int {
  String numToReadableString() {
    return this < 10 && this > 0 ? "0$this" : toString();
  }

  String numToDoubleString() {
    return '$this.0';
  }

  String toMMss() {
    var formattedDuration = '';
    final minutes = this ~/ 60;
    final seconds = this % 60;

    final minutesStr = minutes.toString().padLeft(2, '0');
    final secondsStr = seconds.toString().padLeft(2, '0');
    formattedDuration = '$minutesStr:$secondsStr';
    return formattedDuration;
  }
}
