import 'package:bumn_eid/core/api/response/response_object.dart';
import 'package:bumn_eid/core/models/common/cucu_perusahaan_deni.dart';
import 'package:json_annotation/json_annotation.dart';

part 'cucu_perusahaan_deni_response.g.dart';

@JsonSerializable(createToJson: false)
class CucuPerusahaanDeniResponse extends ResponseObject {
  @JsonKey(name: 'success')
  final bool success;

  @JsonKey(name: 'message')
  final String message;

  @JsonKey(name: 'data')
  final List<CucuPerusahaanDeni> companies;

  CucuPerusahaanDeniResponse({this.success, this.message, this.companies});

  factory CucuPerusahaanDeniResponse.fromJson(Map<String, dynamic> json) =>
      _$CucuPerusahaanDeniResponseFromJson(json);

  static get serializer => _$CucuPerusahaanDeniResponseFromJson;
}