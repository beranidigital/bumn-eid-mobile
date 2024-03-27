// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_item_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchItemResponse _$SearchItemResponseFromJson(Map<String, dynamic> json) {
  return SearchItemResponse(
    success: json['success'] as bool,
    message: json['message'] as String,
    item: (json['data_induk'] as List)
        ?.map((e) => e == null
            ? null
            : SearchPeopleItem.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    itemAnak: (json['data_anak'] as List)
        ?.map((e) => e == null
            ? null
            : SearchPeopleItem.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    itemCucu: (json['data_cucu'] as List)
        ?.map((e) => e == null
            ? null
            : SearchPeopleItem.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    itemTalentPool: (json['data_talent_pool'] as List)
        ?.map((e) => e == null
            ? null
            : SearchPeopleItem.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}
