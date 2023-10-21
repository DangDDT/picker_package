import '../../../core/core_picker.dart';
import 'base/base_data_mapper.dart';

class Mapper {
  final List<BaseDataMapperProfile> _mappers;
  static const String tag = '${CorePicker.packageName}|Mapper';
  const Mapper({
    List<BaseDataMapperProfile>? mappers,
  }) : _mappers = mappers ?? const [];

  GOut mapData<GIn, GOut>(GIn entity) {
    for (final mapper in _mappers) {
      if (mapper is BaseDataMapperProfile<GIn, GOut>) {
        return mapper.mapData(entity);
      }
    }
    throw UnimplementedError('No mapper found for $entity');
  }

  List<GOut> mapListData<GIn, GOut>(List<GIn>? entities) {
    for (final mapper in _mappers) {
      if (mapper is BaseDataMapperProfile<GIn, GOut>) {
        return mapper.mapListData(entities);
      }
    }
    throw UnimplementedError('No mapper found for $entities');
  }
}
