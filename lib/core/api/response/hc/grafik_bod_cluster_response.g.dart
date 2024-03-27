// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'grafik_bod_cluster_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GrafikBODClusterResponse _$GrafikBODClusterResponseFromJson(
    Map<String, dynamic> json) {
  return GrafikBODClusterResponse(
    success: json['success'] as bool,
    message: json['message'] as String,
    totalData: json['total data'] as int,
    data: (json['data'] as List)
        ?.map((e) => e == null
            ? null
            : GrafikBODCluster.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}
