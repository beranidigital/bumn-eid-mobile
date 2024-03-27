// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'talent_pool_item_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TalentPoolItemResponse _$TalentPoolItemResponseFromJson(
    Map<String, dynamic> json) {
  return TalentPoolItemResponse(
    success: json['success'] as bool,
    message: json['message'] as String,
    data: (json['data'] as List)
        ?.map((e) => e == null
            ? null
            : TalentPoolItem.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}
