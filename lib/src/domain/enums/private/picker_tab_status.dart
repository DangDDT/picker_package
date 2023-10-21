enum PickerTabStatus {
  empty,
  readyToSubmit;

  bool get isEmpty => this == PickerTabStatus.empty;
  bool get isReadyToSubmit => this == PickerTabStatus.readyToSubmit;
}
