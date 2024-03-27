import 'package:bumn_eid/core/api/response/response_object.dart';
import 'package:json_annotation/json_annotation.dart';

part 'legal_summary_kota.g.dart';

@JsonSerializable()
class LegalSummaryKota extends ResponseObject {
  @JsonKey(name: 'tahun')
  final int tahun;

  @JsonKey(name: 'kota')
  final String kota;

  @JsonKey(name: 'total_kasus')
  final int total_kasus;

  LegalSummaryKota({
    this.total_kasus,
    this.kota,
    this.tahun,
  });

  factory LegalSummaryKota.fromJson(Map<String, dynamic> json) =>
      _$LegalSummaryKotaFromJson(json);

  static get serializer => _$LegalSummaryKotaFromJson;
}
