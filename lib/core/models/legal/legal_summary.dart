import 'package:bumn_eid/core/api/response/response_object.dart';
import 'package:json_annotation/json_annotation.dart';

part 'legal_summary.g.dart';

@JsonSerializable()
class LegalSummary extends ResponseObject {
  @JsonKey(name: 'total_perkara')
  final int total_perkara;

  @JsonKey(name: 'tingkat_pertama')
  final int tingkat_pertama;

  @JsonKey(name: 'tingkat_banding')
  final int tingkat_banding;

  @JsonKey(name: 'tingkat_kasasi')
  final int tingkat_kasasi;

  @JsonKey(name: 'tingkat_pk')
  final int tingkat_pk;

  @JsonKey(name: 'melibatkan_bumn')
  final int melibatkan_bumn;

  LegalSummary({
    this.melibatkan_bumn,
    this.tingkat_banding,
    this.tingkat_kasasi,
    this.tingkat_pertama,
    this.tingkat_pk,
    this.total_perkara,
  });

  factory LegalSummary.fromJson(Map<String, dynamic> json) =>
      _$LegalSummaryFromJson(json);

  static get serializer => _$LegalSummaryFromJson;
}
