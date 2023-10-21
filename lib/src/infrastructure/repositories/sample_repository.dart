import 'package:get/get.dart';

import '../../domain/domain.dart';
import '../clients/sample_client.dart';

class SampleRepository implements SampleService {
  final SampleApiClient _client;

  SampleRepository({SampleApiClient? client}) : _client = client ??= Get.find<SampleApiClient>();

  @override
  Future<bool> getSamples() {
    throw UnimplementedError();
  }

  @override
  Future<bool> createSample({required SampleRequest body}) {
    throw UnimplementedError();
  }

  @override
  Future<bool> deleteSample({required int id}) {
    throw UnimplementedError();
  }

  @override
  Future<bool> getSample({required int id}) {
    throw UnimplementedError();
  }

  @override
  Future<bool> updateSample({required int id}) {
    throw UnimplementedError();
  }
}
