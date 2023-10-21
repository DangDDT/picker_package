import 'package:get/get.dart';

mixin PagingMixin on GetxController {
  abstract final int _pageSize;

  final _currentPage = 0.obs;

  final _getFirstData = true.obs;

  final _lastPage = false.obs;
  set setLastPage(bool value) => _lastPage.call(value);

  final _isFetchingMore = false.obs;

  bool get isFetchMore => _isFetchingMore.value;

  int get currentPage => _currentPage.value;

  bool get lastPage => _lastPage.value;

  bool get getFirstData => _getFirstData.value;
  set setFirstData(bool value) => _getFirstData.call(value);

  int get pageSize => _pageSize;

  @override
  Future<void> refresh() async {
    _currentPage.call(0);
    _lastPage.call(false);
    _getFirstData.call(true);
    await fetchItems();
  }

  Future<void> fetchItems();

  Future<void> nextPage() async {
    if (lastPage) {
      return;
    }
    _isFetchingMore.call(true);
    _currentPage.call(_currentPage.value + 1);
    await fetchItems();
    _isFetchingMore.call(false);
  }
}
