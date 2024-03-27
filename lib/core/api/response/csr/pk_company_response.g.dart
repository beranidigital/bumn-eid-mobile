// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pk_company_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PkCompanyResponse _$PkCompanyResponseFromJson(Map<String, dynamic> json) {
  return PkCompanyResponse(
    success: json['success'] as bool,
    message: json['message'] as String,
    data: (json['data'] as List)
        ?.map((e) => e == null
            ? null
            : PkItemCompany.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}
