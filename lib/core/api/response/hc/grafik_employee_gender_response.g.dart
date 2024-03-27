// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'grafik_employee_gender_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GrafikEmployeeGenderResponse _$GrafikEmployeeGenderResponseFromJson(
    Map<String, dynamic> json) {
  return GrafikEmployeeGenderResponse(
    success: json['success'] as bool,
    message: json['message'] as String,
    totalData: json['total data'] as int,
    data: (json['data'] as List)
        ?.map((e) => e == null
            ? null
            : GrafikEmployeeGender.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}
