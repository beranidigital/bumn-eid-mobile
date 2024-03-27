import 'package:bumn_eid/core/api/response/response_object.dart';
import 'package:bumn_eid/core/models/hc/talent_pool_by_company.dart';
import 'package:json_annotation/json_annotation.dart';

part 'talent_pool_by_company_response.g.dart';

@JsonSerializable(createToJson: false)
class TalentPoolByCompanyResponse extends ResponseObject {
  @JsonKey(name: 'success')
  final bool success;

  @JsonKey(name: 'message')
  final String message;

  @JsonKey(name: 'data')
  final List<TalentPoolByCompany> data;

  TalentPoolByCompanyResponse({this.success, this.message, this.data});

  factory TalentPoolByCompanyResponse.fromJson(Map<String, dynamic> json) =>
      _$TalentPoolByCompanyResponseFromJson(json);

  static get serializer => _$TalentPoolByCompanyResponseFromJson;
}