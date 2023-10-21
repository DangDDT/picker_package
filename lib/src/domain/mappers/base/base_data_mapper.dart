abstract class BaseDataMapperProfile<GIn, GOut> {
  const BaseDataMapperProfile();

  GOut mapData(GIn? entity);

  List<GOut> mapListData(List<GIn>? entities) {
    return entities?.map(mapData).toList() ?? List.empty();
  }
}

mixin DataMapperMixin<GIn, GOut> on BaseDataMapperProfile<GIn, GOut> {
  @override
  GOut mapData(GIn? entity);

  @override
  List<GOut> mapListData(List<GIn>? entities) {
    return entities?.map((e) => mapData(e)).toList() ?? List.empty();
  }

  GIn mapToData(GOut entity);

  GIn? mapToNullableData(GOut? entity) {
    if (entity == null) {
      return null;
    }

    return mapToData(entity);
  }

  List<GIn>? mapToNullableListData(List<GOut>? listEntity) {
    return listEntity?.map(mapToData).toList();
  }

  List<GIn> mapToListData(List<GOut>? listEntity) {
    return mapToNullableListData(listEntity) ?? List.empty();
  }
}
