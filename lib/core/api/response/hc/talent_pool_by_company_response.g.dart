// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'talent_pool_by_company_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TalentPoolByCompanyResponse _$TalentPoolByCompanyResponseFromJson(
    Map<String, dynamic> json) {
  return TalentPoolByCompanyResponse(
    success: json['success'] as bool,
    message: json['message'] as String,
    data: (json['data'] as List)
        ?.map((e) => e == null
            ? null
            : TalentPoolByCompany.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}
