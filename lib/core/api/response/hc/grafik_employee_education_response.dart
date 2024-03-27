import 'package:bumn_eid/core/api/response/response_object.dart';
import 'package:bumn_eid/core/models/hc/grafik_employee_education.dart';
import 'package:json_annotation/json_annotation.dart';

part 'grafik_employee_education_response.g.dart';

@JsonSerializable(createToJson: false)
class GrafikEmployeeEducationResponse extends ResponseObject {
  @JsonKey(name: 'success')
  final bool success;

  @JsonKey(name: 'message')
  final String message;

  @JsonKey(name: 'total data')
  final int totalData;

  @JsonKey(name: 'data')
  final List<GrafikEmployeeEducation> data;

  GrafikEmployeeEducationResponse({this.success, this.message, this.totalData, this.data});

  factory GrafikEmployeeEducationResponse.fromJson(Map<String, dynamic> json) =>
      _$GrafikEmployeeEducationResponseFromJson(json);

  static get serializer => _$GrafikEmployeeEducationResponseFromJson;
}