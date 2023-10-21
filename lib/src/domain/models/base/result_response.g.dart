// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'result_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResultResponse<T> _$ResultResponseFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    ResultResponse<T>(
      message: json['message'] as String?,
      result: _$nullableGenericFromJson(json['result'], fromJsonT),
      statusCode: json['statusCode'] as int?,
    );

Map<String, dynamic> _$ResultResponseToJson<T>(
  ResultResponse<T> instance,
  Object? Function(T value) toJsonT,
) =>
    <String, dynamic>{
      'result': _$nullableGenericToJson(instance.result, toJsonT),
      'message': instance.message,
      'statusCode': instance.statusCode,
    };

T? _$nullableGenericFromJson<T>(
  Object? input,
  T Function(Object? json) fromJson,
) =>
    input == null ? null : fromJson(input);

Object? _$nullableGenericToJson<T>(
  T? input,
  Object? Function(T value) toJson,
) =>
    input == null ? null : toJson(input);

ResultListResponse<T> _$ResultListResponseFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    ResultListResponse<T>(
      message: json['message'] as String?,
      result: (json['result'] as List<dynamic>?)?.map(fromJsonT).toList(),
      statusCode: json['statusCode'] as int?,
    );

Map<String, dynamic> _$ResultListResponseToJson<T>(
  ResultListResponse<T> instance,
  Object? Function(T value) toJsonT,
) =>
    <String, dynamic>{
      'result': instance.result?.map(toJsonT).toList(),
      'message': instance.message,
      'statusCode': instance.statusCode,
    };
