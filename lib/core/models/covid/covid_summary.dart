import 'package:bumn_eid/core/api/response/response_object.dart';
import 'package:json_annotation/json_annotation.dart';

part 'covid_summary.g.dart';

@JsonSerializable()
class CovidSummary extends ResponseObject {

  @JsonKey(name: 'progress_all_bumn')
  final double progressAllBumn;

  @JsonKey(name: 'progress_cluster_tertinggi')
  final double progressClusterTertinggi;

  @JsonKey(name: 'progress_kelas_tertinggi')
  final double progressKelasTertinggi;

  @JsonKey(name: 'progress_totally_ready')
  final double progressTotallyReady;

  @JsonKey(name: 'progress_almost_ready')
  final double progressAlmostReady;

  @JsonKey(name: 'progress_not_ready')
  final double progressNotReady;

  @JsonKey(name: 'kasus_total')
  final int kasusTotal;

  @JsonKey(name: 'kasus_dirawat')
  final int kasusDirawat;

  @JsonKey(name: 'kasus_meninggal')
  final int kasusMeninggal;

  @JsonKey(name: 'kasus_sembuh')
  final int kasusSembuh;

  @JsonKey(name: 'submitted_bumn')
  final int submittedBumn;

  @JsonKey(name: 'sum_score')
  final int sumScore;

  @JsonKey(name: 'cache_time_update')
  final String cacheTimeUpdate;

  CovidSummary({
    this.kasusDirawat,
    this.kasusMeninggal,
    this.kasusSembuh,
    this.kasusTotal,
    this.progressAllBumn,
    this.progressAlmostReady,
    this.progressClusterTertinggi,
    this.progressKelasTertinggi,
    this.progressNotReady,
    this.progressTotallyReady,
    this.cacheTimeUpdate,
    this.submittedBumn,
    this.sumScore
  });

  factory CovidSummary.fromJson(Map<String, dynamic> json) =>
      _$CovidSummaryFromJson(json);

  static get serializer => _$CovidSummaryFromJson;

}