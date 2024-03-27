import 'package:bumn_eid/core/api/response/response_object.dart';
import 'package:bumn_eid/core/models/hc/bod1_company.dart';
import 'package:json_annotation/json_annotation.dart';

part 'bod1_company_response.g.dart';

@JsonSerializable(createToJson: false)
class BOD1CompanyResponse extends ResponseObject {
  @JsonKey(name: 'success')
  final bool success;

  @JsonKey(name: 'message')
  final String message;

  @JsonKey(name: 'data')
  final List<BOD1Company> companies;

  BOD1CompanyResponse({this.success, this.message, this.companies});

  factory BOD1CompanyResponse.fromJson(Map<String, dynamic> json) =>
      _$BOD1CompanyResponseFromJson(json);

  static get serializer => _$BOD1CompanyResponseFromJson;
}