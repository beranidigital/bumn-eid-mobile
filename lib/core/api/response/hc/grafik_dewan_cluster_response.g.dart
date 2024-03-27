// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'grafik_dewan_cluster_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GrafikDewanClusterResponse _$GrafikDewanClusterResponseFromJson(
    Map<String, dynamic> json) {
  return GrafikDewanClusterResponse(
    success: json['success'] as bool,
    message: json['message'] as String,
    totalData: json['total data'] as int,
    data: (json['data'] as List)
        ?.map((e) => e == null
            ? null
            : GrafikDewanKomisarisCluster.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}
