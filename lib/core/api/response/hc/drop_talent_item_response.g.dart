// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'drop_talent_item_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DropTalentItemResponse _$DropTalentItemResponseFromJson(
    Map<String, dynamic> json) {
  return DropTalentItemResponse(
    success: json['success'] as bool,
    message: json['message'] as String,
    pejabat: (json['data'] as List)
        ?.map((e) => e == null
            ? null
            : TalentPoolItem.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}
