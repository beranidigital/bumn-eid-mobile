// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EventItem _$EventItemFromJson(Map<String, dynamic> json) {
  return EventItem(
    id: json['id'] as int,
    date: json['date'] as String,
    eventName: json['event_name'] as String,
  );
}

Map<String, dynamic> _$EventItemToJson(EventItem instance) => <String, dynamic>{
      'id': instance.id,
      'date': instance.date,
      'event_name': instance.eventName,
    };
