// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bod1_cluster_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BOD1ClusterResponse _$BOD1ClusterResponseFromJson(Map<String, dynamic> json) {
  return BOD1ClusterResponse(
    success: json['success'] as bool,
    message: json['message'] as String,
    companies: (json['data'] as List)
        ?.map((e) =>
            e == null ? null : BOD1Cluster.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}
