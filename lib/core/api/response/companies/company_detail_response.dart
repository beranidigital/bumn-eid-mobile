import 'package:bumn_eid/core/api/response/response_object.dart';
import 'package:bumn_eid/core/models/business_portfolio/profil_perusahaan.dart';
import 'package:json_annotation/json_annotation.dart';

part 'company_detail_response.g.dart';

@JsonSerializable(createToJson: false)
class CompanyDetailResponse extends ResponseObject {
  @JsonKey(name: 'success')
  final bool success;

  @JsonKey(name: 'message')
  final String message;

  @JsonKey(name: 'data')
  final List<ProfilPerusahaan> data;


  CompanyDetailResponse({this.success, this.message, this.data});

  factory CompanyDetailResponse.fromJson(Map<String, dynamic> json) =>
      _$CompanyDetailResponseFromJson(json);

  static get serializer => _$CompanyDetailResponseFromJson;
}