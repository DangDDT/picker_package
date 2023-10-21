enum LoadingState {
  initial("Khởi tạo state"),
  loading("Đang tải dữ liệu"),
  success("Tải dữ liệu thành công"),
  error("Có lỗi xảy ra"),
  empty("Không có dữ liệu");

  const LoadingState(this.description);

  final String description;

  get isInitial => this == LoadingState.initial;

  get isLoading => this == LoadingState.loading;

  get isSuccess => this == LoadingState.success;

  get isError => this == LoadingState.error;

  get isEmpty => this == LoadingState.empty;
}
