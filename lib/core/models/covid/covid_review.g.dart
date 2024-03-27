// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'covid_review.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CovidReview _$CovidReviewFromJson(Map<String, dynamic> json) {
  return CovidReview(
    idAngka: json['id_angka'] as String,
    campaign: json['campaign'] as String,
    pencapaian: json['pencapaian'] as String,
    reviewFile: json['review_file'] as String,
    review: json['review'] as String,
    isReview: json['is_review'] as String,
    keterangan: json['keterangan'] as String,
    id: json['id'] as int,
    tanggal: json['tanggal'] as String,
    total: json['total'] as String,
    dirawat: json['dirawat'] as String,
    meninggal: json['meninggal'] as String,
    sembuh: json['sembuh'] as String,
  );
}

Map<String, dynamic> _$CovidReviewToJson(CovidReview instance) =>
    <String, dynamic>{
      'id': instance.id,
      'id_angka': instance.idAngka,
      'tanggal': instance.tanggal,
      'pencapaian': instance.pencapaian,
      'review': instance.review,
      'review_file': instance.reviewFile,
      'is_review': instance.isReview,
      'keterangan': instance.keterangan,
      'dirawat': instance.dirawat,
      'meninggal': instance.meninggal,
      'sembuh': instance.sembuh,
      'total': instance.total,
      'campaign': instance.campaign,
    };
