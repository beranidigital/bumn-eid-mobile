// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'talent_detail_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TalentDetailResponse _$TalentDetailResponseFromJson(Map<String, dynamic> json) {
  return TalentDetailResponse(
    success: json['success'] as bool,
    message: json['message'] as String,
    totalData: json['total data'] as int,
    data: (json['data'] as List)
        ?.map((e) =>
            e == null ? null : TalentDetail.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}
