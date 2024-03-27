// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'last_update.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LastUpdate _$LastUpdateFromJson(Map<String, dynamic> json) {
  return LastUpdate(
    pageName: json['page_name'] as String,
    lastUpdated: json['updated_date'] as String,
  );
}

Map<String, dynamic> _$LastUpdateToJson(LastUpdate instance) =>
    <String, dynamic>{
      'page_name': instance.pageName,
      'updated_date': instance.lastUpdated,
    };
