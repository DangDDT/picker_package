import 'package:freezed_annotation/freezed_annotation.dart';

part 'data_response.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class DataResponse<T> {
  DataResponse({
    @JsonKey(name: 'message') this.message,
    @JsonKey(name: 'data') this.data,
    @JsonKey(name: 'statusCode') this.statusCode,
  });

  // ignore: avoid-dynamic
  factory DataResponse.fromJson(Map<String, dynamic> json, T Function(dynamic) fromJsonT) =>
      _$DataResponseFromJson(json, fromJsonT);

  final T? data;
  final String? message;
  final int? statusCode;
}

@JsonSerializable(genericArgumentFactories: true)
class DataListResponse<T> {
  DataListResponse({
    @JsonKey(name: 'message') this.message,
    @JsonKey(name: 'data') this.data,
    @JsonKey(name: 'statusCode') this.statusCode,
  });

  // ignore: avoid-dynamic
  factory DataListResponse.fromJson(Map<String, dynamic> json, T Function(dynamic) fromJsonT) =>
      _$DataListResponseFromJson(json, fromJsonT);

  final List<T>? data;
  final String? message;
  final int? statusCode;
}
