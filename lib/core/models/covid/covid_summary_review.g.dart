// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'covid_summary_review.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CovidSummaryReview _$CovidSummaryReviewFromJson(Map<String, dynamic> json) {
  return CovidSummaryReview(
    tanggalReview: json['tanggal_review'] as String,
    keterangan: json['keterangan'] as String,
    pencapaian: json['pencapaian'] as String,
    timelineAll: json['timeline_all'] as int,
    timelineRed: json['timeline_red'] as int,
    timelineYellow: json['timeline_yellow'] as int,
    timelineGreen: json['timeline_green'] as int,
  );
}

Map<String, dynamic> _$CovidSummaryReviewToJson(CovidSummaryReview instance) =>
    <String, dynamic>{
      'tanggal_review': instance.tanggalReview,
      'pencapaian': instance.pencapaian,
      'keterangan': instance.keterangan,
      'timeline_all': instance.timelineAll,
      'timeline_red': instance.timelineRed,
      'timeline_yellow': instance.timelineYellow,
      'timeline_green': instance.timelineGreen,
    };
