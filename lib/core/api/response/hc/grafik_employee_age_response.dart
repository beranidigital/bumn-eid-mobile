import 'package:bumn_eid/core/api/response/response_object.dart';
import 'package:bumn_eid/core/models/hc/grafik_employee_age.dart';
import 'package:json_annotation/json_annotation.dart';

part 'grafik_employee_age_response.g.dart';

@JsonSerializable(createToJson: false)
class GrafikEmployeeAgeResponse extends ResponseObject {
  @JsonKey(name: 'success')
  final bool success;

  @JsonKey(name: 'message')
  final String message;

  @JsonKey(name: 'total data')
  final int totalData;

  @JsonKey(name: 'data')
  final List<GrafikEmployeeAge> data;

  GrafikEmployeeAgeResponse({this.success, this.message, this.totalData, this.data});

  factory GrafikEmployeeAgeResponse.fromJson(Map<String, dynamic> json) =>
      _$GrafikEmployeeAgeResponseFromJson(json);

  static get serializer => _$GrafikEmployeeAgeResponseFromJson;
}