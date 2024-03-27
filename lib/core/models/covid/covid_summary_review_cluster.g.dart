// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'covid_summary_review_cluster.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CovidSummaryReviewCluster _$CovidSummaryReviewClusterFromJson(
    Map<String, dynamic> json) {
  return CovidSummaryReviewCluster(
    tanggalReview: json['tanggal'] as String,
    keterangan: json['keterangan'] as String,
    pencapaian: json['pencapaian'] as String,
    id: json['id'] as int,
    nama: json['nama_lengkap'] as String,
    reviewFile:
        (json['review_file'] as List)?.map((e) => e as String)?.toList(),
    isReview: json['is_review'] as String,
    timelineAll: json['timeline_all'] as int,
    timelineRed: json['timeline_red'] as int,
    timelineYellow: json['timeline_yellow'] as int,
    timelineGreen: json['timeline_green'] as int,
  );
}

Map<String, dynamic> _$CovidSummaryReviewClusterToJson(
        CovidSummaryReviewCluster instance) =>
    <String, dynamic>{
      'id': instance.id,
      'nama_lengkap': instance.nama,
      'is_review': instance.isReview,
      'review_file': instance.reviewFile,
      'tanggal': instance.tanggalReview,
      'pencapaian': instance.pencapaian,
      'keterangan': instance.keterangan,
      'timeline_all': instance.timelineAll,
      'timeline_red': instance.timelineRed,
      'timeline_yellow': instance.timelineYellow,
      'timeline_green': instance.timelineGreen,
    };
