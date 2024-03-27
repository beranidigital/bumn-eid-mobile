// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'covid_company_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CovidCompanyListResponse _$CovidCompanyListResponseFromJson(
    Map<String, dynamic> json) {
  return CovidCompanyListResponse(
    success: json['success'] as bool,
    message: json['message'] as String,
    data: (json['data'] as List)
        ?.map((e) => e == null
            ? null
            : CovidCompanyList.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    review: (json['data_review'] as List)
        ?.map((e) => e == null
            ? null
            : CovidSummaryReviewCluster.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}
