// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dekom_detailed_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DekomDetailedResponse _$DekomDetailedResponseFromJson(
    Map<String, dynamic> json) {
  return DekomDetailedResponse(
    success: json['success'] as bool,
    message: json['message'] as String,
    totalData: json['total data'] as int,
    data: (json['data'] as List)
        ?.map((e) => e == null
            ? null
            : DekomDetailedItem.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}
