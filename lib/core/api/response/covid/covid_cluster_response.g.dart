// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'covid_cluster_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CovidClusterResponse _$CovidClusterResponseFromJson(Map<String, dynamic> json) {
  return CovidClusterResponse(
    success: json['success'] as bool,
    message: json['message'] as String,
    data: (json['data'] as List)
        ?.map((e) =>
            e == null ? null : CovidCluster.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}
