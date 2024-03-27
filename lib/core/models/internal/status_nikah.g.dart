// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'status_nikah.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StatusNikah _$StatusNikahFromJson(Map<String, dynamic> json) {
  return StatusNikah(
    statusNikah: json['status_nikah'] as String,
    total: json['total'] as int,
  );
}

Map<String, dynamic> _$StatusNikahToJson(StatusNikah instance) =>
    <String, dynamic>{
      'status_nikah': instance.statusNikah,
      'total': instance.total,
    };
