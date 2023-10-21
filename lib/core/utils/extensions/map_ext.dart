extension MapExt<K, L extends List> on Map<K, L> {
  ///move element to last if test is true
  ///test is key
  ///example: {1: [1,2,3], 2: [4,5,6], 3: [7,8,9]}
  ///example: moveLastIfKey((int key) => key == 1)
  ///result: {2: [4,5,6], 3:[7,8,9], 1: [1,2,3]}
  Map<K, L> moveLastWhereKey(bool Function(K key) test) {
    final Map<K, L> result = {};
    final List<K> keys = [];
    for (final K key in this.keys) {
      if (test(key)) {
        keys.add(key);
      } else {
        result[key] = this[key]!;
      }
    }
    for (final K key in keys) {
      result[key] = this[key]!;
    }
    return result;
  }
}

extension KeyPath on Map {
  Object? valueFor({required String keyPath}) {
    final keysSplit = keyPath.split('.');
    final thisKey = keysSplit.removeAt(0);
    final thisValue = this[thisKey];
    if (keysSplit.isEmpty) {
      return thisValue;
    } else if (thisValue is Map) {
      return thisValue.valueFor(keyPath: keysSplit.join('.'));
    }
    return null;
  }
}
