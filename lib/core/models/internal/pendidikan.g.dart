// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pendidikan.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Pendidikan _$PendidikanFromJson(Map<String, dynamic> json) {
  return Pendidikan(
    pendidikan: json['pendidikan'] as String,
    total: json['total'] as int,
  );
}

Map<String, dynamic> _$PendidikanToJson(Pendidikan instance) =>
    <String, dynamic>{
      'pendidikan': instance.pendidikan,
      'total': instance.total,
    };
