// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'covid_summary_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CovidSummaryResponse _$CovidSummaryResponseFromJson(Map<String, dynamic> json) {
  return CovidSummaryResponse(
    success: json['success'] as bool,
    message: json['message'] as String,
    data: json['data'] == null
        ? null
        : CovidSummary.fromJson(json['data'] as Map<String, dynamic>),
    review: (json['data_review'] as List)
        ?.map((e) => e == null
            ? null
            : CovidSummaryReview.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}
