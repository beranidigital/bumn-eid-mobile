import 'package:bumn_eid/core/api/response/response_object.dart';
import 'package:bumn_eid/core/models/csr/pk_item_company.dart';
import 'package:json_annotation/json_annotation.dart';

part 'pk_company_response.g.dart';

@JsonSerializable(createToJson: false)
class PkCompanyResponse extends ResponseObject {
  @JsonKey(name: 'success')
  final bool success;

  @JsonKey(name: 'message')
  final String message;

  @JsonKey(name: 'data')
  final List<PkItemCompany> data;


  PkCompanyResponse({this.success, this.message, this.data});

  factory PkCompanyResponse.fromJson(Map<String, dynamic> json) =>
      _$PkCompanyResponseFromJson(json);

  static get serializer => _$PkCompanyResponseFromJson;
}