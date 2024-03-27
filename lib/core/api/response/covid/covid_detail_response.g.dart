// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'covid_detail_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CovidDetailResponse _$CovidDetailResponseFromJson(Map<String, dynamic> json) {
  return CovidDetailResponse(
    success: json['success'] as bool,
    message: json['message'] as String,
    data: (json['data'] as List)
        ?.map((e) =>
            e == null ? null : CovidDetail.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    review: (json['data_review'] as List)
        ?.map((e) =>
            e == null ? null : CovidReview.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}
