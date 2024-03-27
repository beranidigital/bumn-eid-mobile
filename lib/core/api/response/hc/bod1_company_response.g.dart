// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bod1_company_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BOD1CompanyResponse _$BOD1CompanyResponseFromJson(Map<String, dynamic> json) {
  return BOD1CompanyResponse(
    success: json['success'] as bool,
    message: json['message'] as String,
    companies: (json['data'] as List)
        ?.map((e) =>
            e == null ? null : BOD1Company.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}
