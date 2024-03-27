// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'covid_summary.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CovidSummary _$CovidSummaryFromJson(Map<String, dynamic> json) {
  return CovidSummary(
    kasusDirawat: json['kasus_dirawat'] as int,
    kasusMeninggal: json['kasus_meninggal'] as int,
    kasusSembuh: json['kasus_sembuh'] as int,
    kasusTotal: json['kasus_total'] as int,
    progressAllBumn: (json['progress_all_bumn'] as num)?.toDouble(),
    progressAlmostReady: (json['progress_almost_ready'] as num)?.toDouble(),
    progressClusterTertinggi:
        (json['progress_cluster_tertinggi'] as num)?.toDouble(),
    progressKelasTertinggi:
        (json['progress_kelas_tertinggi'] as num)?.toDouble(),
    progressNotReady: (json['progress_not_ready'] as num)?.toDouble(),
    progressTotallyReady: (json['progress_totally_ready'] as num)?.toDouble(),
    cacheTimeUpdate: json['cache_time_update'] as String,
    submittedBumn: json['submitted_bumn'] as int,
    sumScore: json['sum_score'] as int,
  );
}

Map<String, dynamic> _$CovidSummaryToJson(CovidSummary instance) =>
    <String, dynamic>{
      'progress_all_bumn': instance.progressAllBumn,
      'progress_cluster_tertinggi': instance.progressClusterTertinggi,
      'progress_kelas_tertinggi': instance.progressKelasTertinggi,
      'progress_totally_ready': instance.progressTotallyReady,
      'progress_almost_ready': instance.progressAlmostReady,
      'progress_not_ready': instance.progressNotReady,
      'kasus_total': instance.kasusTotal,
      'kasus_dirawat': instance.kasusDirawat,
      'kasus_meninggal': instance.kasusMeninggal,
      'kasus_sembuh': instance.kasusSembuh,
      'submitted_bumn': instance.submittedBumn,
      'sum_score': instance.sumScore,
      'cache_time_update': instance.cacheTimeUpdate,
    };
