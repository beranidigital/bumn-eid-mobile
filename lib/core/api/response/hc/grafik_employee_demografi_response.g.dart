// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'grafik_employee_demografi_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GrafikEmployeeDemografiResponse _$GrafikEmployeeDemografiResponseFromJson(
    Map<String, dynamic> json) {
  return GrafikEmployeeDemografiResponse(
    success: json['success'] as bool,
    message: json['message'] as String,
    totalData: json['total data'] as int,
    data: (json['data'] as List)
        ?.map((e) => e == null
            ? null
            : GrafikEmployeeDemografi.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}
