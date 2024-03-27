// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hc_companies_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HcCompaniesResponse _$HcCompaniesResponseFromJson(Map<String, dynamic> json) {
  return HcCompaniesResponse(
    success: json['success'] as bool,
    message: json['message'] as String,
    data: (json['data'] as List)
        ?.map((e) =>
            e == null ? null : HcCompany.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}
