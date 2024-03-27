import 'package:bumn_eid/core/api/response/response_object.dart';
import 'package:bumn_eid/core/models/common/kinerja_perusahaan.dart';
import 'package:bumn_eid/core/models/business_portfolio/profil_perusahaan.dart';
import 'package:json_annotation/json_annotation.dart';

part 'kinerja_perusahaan_response.g.dart';

@JsonSerializable(createToJson: false)
class KinerjaPerusahaanResponse extends ResponseObject {
  @JsonKey(name: 'success')
  final bool success;

  @JsonKey(name: 'message')
  final String message;

  @JsonKey(name: 'data')
  final List<KinerjaPerusahaan> data;


  KinerjaPerusahaanResponse({this.success, this.message, this.data});

  factory KinerjaPerusahaanResponse.fromJson(Map<String, dynamic> json) =>
      _$KinerjaPerusahaanResponseFromJson(json);

  static get serializer => _$KinerjaPerusahaanResponseFromJson;
}