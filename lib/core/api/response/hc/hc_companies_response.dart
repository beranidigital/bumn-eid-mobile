import 'package:bumn_eid/core/api/response/response_object.dart';
import 'package:bumn_eid/core/models/hc/hc_company.dart';
import 'package:json_annotation/json_annotation.dart';

part 'hc_companies_response.g.dart';

@JsonSerializable(createToJson: false)
class HcCompaniesResponse extends ResponseObject {
  @JsonKey(name: 'success')
  final bool success;

  @JsonKey(name: 'message')
  final String message;

  @JsonKey(name: 'data')
  final List<HcCompany> data;

  HcCompaniesResponse({this.success, this.message, this.data});

  factory HcCompaniesResponse.fromJson(Map<String, dynamic> json) =>
      _$HcCompaniesResponseFromJson(json);

  static get serializer => _$HcCompaniesResponseFromJson;
}