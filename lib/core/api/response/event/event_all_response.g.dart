// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_all_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EventAllResponse _$EventAllResponseFromJson(Map<String, dynamic> json) {
  return EventAllResponse(
    success: json['success'] as bool,
    message: json['message'] as String,
    data: (json['data'] as List)
        ?.map((e) =>
            e == null ? null : EventItem.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}
