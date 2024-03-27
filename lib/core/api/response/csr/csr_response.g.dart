// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'csr_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CsrResponse _$CsrResponseFromJson(Map<String, dynamic> json) {
  return CsrResponse(
    success: json['success'] as bool,
    message: json['message'] as String,
    data: (json['data'] as List)
        ?.map((e) =>
            e == null ? null : CsrItem.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}
