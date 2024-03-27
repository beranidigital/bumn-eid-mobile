// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'employee_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EmployeeResponse _$EmployeeResponseFromJson(Map<String, dynamic> json) {
  return EmployeeResponse(
    success: json['success'] as bool,
    message: json['message'] as String,
    currentPage: json['current_page'] as int,
    data: (json['data'] as List)
        ?.map((e) =>
            e == null ? null : Employee.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}
