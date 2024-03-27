import 'package:bumn_eid/core/api/response/response_object.dart';
import 'package:bumn_eid/core/models/csr/csr_company.dart';
import 'package:json_annotation/json_annotation.dart';

part 'csr_company_response.g.dart';

@JsonSerializable(createToJson: false)
class CsrCompanyResponse extends ResponseObject {
  @JsonKey(name: 'success')
  final bool success;

  @JsonKey(name: 'message')
  final String message;

  @JsonKey(name: 'total_data')
  final int totalData;

  @JsonKey(name: 'data')
  final List<CsrCompany> data;


  CsrCompanyResponse({this.success, this.message, this.totalData, this.data});

  factory CsrCompanyResponse.fromJson(Map<String, dynamic> json) =>
      _$CsrCompanyResponseFromJson(json);

  static get serializer => _$CsrCompanyResponseFromJson;
}