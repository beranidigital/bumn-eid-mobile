// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'talent_pool_by_cluster_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TalentPoolByClusterResponse _$TalentPoolByClusterResponseFromJson(
    Map<String, dynamic> json) {
  return TalentPoolByClusterResponse(
    success: json['success'] as bool,
    message: json['message'] as String,
    data: (json['data'] as List)
        ?.map((e) => e == null
            ? null
            : TalentPoolByCluster.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}
