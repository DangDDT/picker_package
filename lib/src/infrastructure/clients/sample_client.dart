// ignore_for_file: depend_on_referenced_packages

import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'sample_client.g.dart';

@RestApi(baseUrl: "https://sample-api.tech/")
abstract class SampleApiClient {
  factory SampleApiClient(Dio dio, {String baseUrl}) = _SampleApiClient;

  @GET("/samples")
  Future<bool> getSamples();

  @GET("/samples/{id}")
  Future<bool> getSample(@Path("id") int id);

  @POST("/samples")
  Future<bool> createSample(@Body() Map<String, dynamic> body);

  @PUT("/samples/{id}")
  Future<bool> updateSample(@Path("id") int id);

  @DELETE("/samples/{id}")
  Future<bool> deleteSample(@Path("id") int id);
}
