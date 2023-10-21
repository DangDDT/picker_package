extension ListExt<E> on List<E> {
  /// Return first element that match [test] or null if not found
  E? firstOrDefault(
    bool Function(E element) test, {
    E? Function()? orDefault,
  }) {
    for (E element in this) {
      if (test(element)) return element;
    }
    if (orDefault != null) return orDefault();
    return null;
  }

  /// Add element to list if not contains
  bool addIfNotContains(E element, bool Function(E element) test) {
    if (firstOrDefault(test) == null) {
      add(element);
      return true;
    }
    return false;
  }

  /// Return a new list with all element that not null
  int countWhere(bool Function(E e) test) => where((e) => test.call(e)).length;

  /// Return a new list with all element that not null
  List<E> whereNotNull() => where((e) => e != null).toList();

  /// Replace all element in list that match [test] with [replace] and return replaced elements
  List<E> replaceWhere(bool Function(E e) test, E replace) {
    final replaced = <E>[];
    for (int i = 0; i < length; i++) {
      if (test(this[i])) {
        replaced.add(this[i]);
        this[i] = replace;
      }
    }
    return replaced;
  }

  E? firstOrNull() {
    if (isEmpty) return null;
    return first;
  }

  List<E>? differenceElementWithOutRespectivelyOrder(List<E> other) {
    final result = <E>[];
    for (final element in this) {
      if (!other.contains(element)) {
        result.add(element);
      }
    }
    return result;
  }

  /// Return a new list with all element that not null without reference to the original list
  List<E>? clone() {
    if (isEmpty) return null;
    return List<E>.from(this);
  }
}

extension ListExtNull<E> on List<E>? {
  /// Return a new list with all element that not null without reference to the original list
  List<E>? cloneOrNull() {
    if (this == null) return null;
    if (this!.isEmpty) return null;
    return List<E>.from(this!);
  }

  List<E>? useForEachAddToList() {
    if (this == null) return null;
    final result = <E>[];
    for (var element in this!) {
      result.add(element);
    }
    return result;
  }

  /// Return a new list with all element that not null with respect to the original list
  /// Example: [1, 2, 3, null, 4, null, 5] => [1, 2, 3, 4, 5]
  ///
  /// Note: This method will remove all null element in the original list
  flattenDeep({int? depth}) => this
      ?.expand((e) => e is List && ((depth ?? 1) > 0 || depth == null)
          ? e.flattenDeep(depth: depth == null ? null : depth - 1)
          : [e])
      .toList(growable: false);
}
