// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'result_response.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class ResultResponse<T> {
  ResultResponse({
    @JsonKey(name: 'message') this.message,
    @JsonKey(name: 'result') this.result,
    @JsonKey(name: 'statusCode') this.statusCode,
  });

  // ignore: avoid-dynamic
  factory ResultResponse.fromJson(Map<String, dynamic> json, T Function(dynamic) fromJsonT) =>
      _$ResultResponseFromJson(json, fromJsonT);

  final T? result;
  final String? message;
  final int? statusCode;
}

@JsonSerializable(genericArgumentFactories: true)
class ResultListResponse<T> {
  ResultListResponse({
    @JsonKey(name: 'message') this.message,
    @JsonKey(name: 'result') this.result,
    @JsonKey(name: 'statusCode') this.statusCode,
  });

  // ignore: avoid-dynamic
  factory ResultListResponse.fromJson(Map<String, dynamic> json, T Function(dynamic) fromJsonT) =>
      _$ResultListResponseFromJson(json, fromJsonT);

  final List<T>? result;
  final String? message;
  final int? statusCode;
}
