// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'loan_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoanResponse _$LoanResponseFromJson(Map<String, dynamic> json) {
  return LoanResponse(
    success: json['success'] as bool,
    message: json['message'] as String,
    companies: (json['data'] as List)
        ?.map(
            (e) => e == null ? null : Loan.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}
