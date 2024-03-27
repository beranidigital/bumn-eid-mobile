// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'third_party_loan_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ThirdPartyLoanResponse _$ThirdPartyLoanResponseFromJson(
    Map<String, dynamic> json) {
  return ThirdPartyLoanResponse(
    success: json['success'] as bool,
    message: json['message'] as String,
    companies: (json['data'] as List)
        ?.map((e) => e == null
            ? null
            : ThirdPartyLoan.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}
