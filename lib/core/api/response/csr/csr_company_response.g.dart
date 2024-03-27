// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'csr_company_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CsrCompanyResponse _$CsrCompanyResponseFromJson(Map<String, dynamic> json) {
  return CsrCompanyResponse(
    success: json['success'] as bool,
    message: json['message'] as String,
    totalData: json['total_data'] as int,
    data: (json['data'] as List)
        ?.map((e) =>
            e == null ? null : CsrCompany.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}
