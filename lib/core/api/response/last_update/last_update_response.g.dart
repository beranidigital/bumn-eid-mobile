// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'last_update_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LastUpdateResponse _$LastUpdateResponseFromJson(Map<String, dynamic> json) {
  return LastUpdateResponse(
    success: json['success'] as bool,
    message: json['message'] as String,
    data: (json['data'] as List)
        ?.map((e) =>
            e == null ? null : LastUpdate.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}
