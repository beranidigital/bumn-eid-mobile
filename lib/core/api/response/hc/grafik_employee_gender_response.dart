import 'package:bumn_eid/core/api/response/response_object.dart';
import 'package:bumn_eid/core/models/hc/grafik_employee_gender.dart';
import 'package:json_annotation/json_annotation.dart';

part 'grafik_employee_gender_response.g.dart';

@JsonSerializable(createToJson: false)
class GrafikEmployeeGenderResponse extends ResponseObject {
  @JsonKey(name: 'success')
  final bool success;

  @JsonKey(name: 'message')
  final String message;

  @JsonKey(name: 'total data')
  final int totalData;

  @JsonKey(name: 'data')
  final List<GrafikEmployeeGender> data;

  GrafikEmployeeGenderResponse({this.success, this.message, this.totalData, this.data});

  factory GrafikEmployeeGenderResponse.fromJson(Map<String, dynamic> json) =>
      _$GrafikEmployeeGenderResponseFromJson(json);

  static get serializer => _$GrafikEmployeeGenderResponseFromJson;
}