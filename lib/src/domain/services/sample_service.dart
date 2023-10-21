import '../requests/_sample_request.dart';

abstract class SampleService {
  Future<bool> getSamples();
  Future<bool> getSample({required int id});
  Future<bool> createSample({required SampleRequest body});
  Future<bool> updateSample({required int id});
  Future<bool> deleteSample({required int id});
}
