abstract class DataFilterMapper<T> {
  const DataFilterMapper();

  factory DataFilterMapper.fromType(DataFilterMapperType type) {
    switch (type) {
      case DataFilterMapperType.defaultFilter:
      default:
        throw UnimplementedError();
    }
  }

  // ignore: avoid-dynamic
  T filterData(T response);
}

enum DataFilterMapperType { defaultFilter }
