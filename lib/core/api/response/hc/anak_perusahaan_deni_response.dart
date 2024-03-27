import 'package:bumn_eid/core/api/response/response_object.dart';
import 'package:bumn_eid/core/models/common/anak_perusahaan_deni.dart';
import 'package:json_annotation/json_annotation.dart';

part 'anak_perusahaan_deni_response.g.dart';

@JsonSerializable(createToJson: false)
class AnakPerusahaanDeniResponse extends ResponseObject {
  @JsonKey(name: 'success')
  final bool success;

  @JsonKey(name: 'message')
  final String message;

  @JsonKey(name: 'data')
  final List<AnakPerusahaanDeni> companies;

  AnakPerusahaanDeniResponse({this.success, this.message, this.companies});

  factory AnakPerusahaanDeniResponse.fromJson(Map<String, dynamic> json) =>
      _$AnakPerusahaanDeniResponseFromJson(json);

  static get serializer => _$AnakPerusahaanDeniResponseFromJson;
}