// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'company_detail_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CompanyDetailResponse _$CompanyDetailResponseFromJson(
    Map<String, dynamic> json) {
  return CompanyDetailResponse(
    success: json['success'] as bool,
    message: json['message'] as String,
    data: (json['data'] as List)
        ?.map((e) => e == null
            ? null
            : ProfilPerusahaan.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}
