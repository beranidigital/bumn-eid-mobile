// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'grafik_employee_education_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GrafikEmployeeEducationResponse _$GrafikEmployeeEducationResponseFromJson(
    Map<String, dynamic> json) {
  return GrafikEmployeeEducationResponse(
    success: json['success'] as bool,
    message: json['message'] as String,
    totalData: json['total data'] as int,
    data: (json['data'] as List)
        ?.map((e) => e == null
            ? null
            : GrafikEmployeeEducation.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}
