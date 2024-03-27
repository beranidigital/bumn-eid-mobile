import 'package:bumn_eid/core/api/response/response_object.dart';
import 'package:bumn_eid/core/models/legal/legal_summary.dart';
import 'package:bumn_eid/core/models/legal/legal_summary_bumn.dart';
import 'package:bumn_eid/core/models/legal/legal_summary_jenis.dart';
import 'package:bumn_eid/core/models/legal/legal_summary_kota.dart';
import 'package:json_annotation/json_annotation.dart';

part 'legal_summary_data.g.dart';

@JsonSerializable()
class LegalSummaryData extends ResponseObject {
  @JsonKey(name: 'summary_all')
  final LegalSummary legalSummaryAll;

  @JsonKey(name: 'summary_jenis')
  final LegalSummaryJenis summary_jenis;

  @JsonKey(name: 'summary_bumn')
  final List<LegalSummaryBumn> summary_bumn;

  @JsonKey(name: 'summary_kota')
  final List<LegalSummaryKota> summary_kota;

  LegalSummaryData({
    this.legalSummaryAll,
    this.summary_bumn,
    this.summary_jenis,
    this.summary_kota,
  });

  factory LegalSummaryData.fromJson(Map<String, dynamic> json) =>
      _$LegalSummaryDataFromJson(json);

  static get serializer => _$LegalSummaryDataFromJson;
}
