// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'grafik_employee_age_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GrafikEmployeeAgeResponse _$GrafikEmployeeAgeResponseFromJson(
    Map<String, dynamic> json) {
  return GrafikEmployeeAgeResponse(
    success: json['success'] as bool,
    message: json['message'] as String,
    totalData: json['total data'] as int,
    data: (json['data'] as List)
        ?.map((e) => e == null
            ? null
            : GrafikEmployeeAge.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}
