// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session_response_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SessionResponseData _$SessionResponseDataFromJson(Map<String, dynamic> json) {
  return SessionResponseData(
    user: json['user'] == null
        ? null
        : User.fromJson(json['user'] as Map<String, dynamic>),
    token: json['token'] as String,
    role: (json['role'] as List)?.map((e) => e as String)?.toList(),
  );
}
