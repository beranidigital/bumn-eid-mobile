import 'package:bumn_eid/core/api/response/response_object.dart';
import 'package:bumn_eid/core/models/hc/grafik_employee_demografi.dart';
import 'package:json_annotation/json_annotation.dart';

part 'grafik_employee_demografi_response.g.dart';

@JsonSerializable(createToJson: false)
class GrafikEmployeeDemografiResponse extends ResponseObject {
  @JsonKey(name: 'success')
  final bool success;

  @JsonKey(name: 'message')
  final String message;

  @JsonKey(name: 'total data')
  final int totalData;

  @JsonKey(name: 'data')
  final List<GrafikEmployeeDemografi> data;

  GrafikEmployeeDemografiResponse({this.success, this.message, this.totalData, this.data});

  factory GrafikEmployeeDemografiResponse.fromJson(Map<String, dynamic> json) =>
      _$GrafikEmployeeDemografiResponseFromJson(json);

  static get serializer => _$GrafikEmployeeDemografiResponseFromJson;
}