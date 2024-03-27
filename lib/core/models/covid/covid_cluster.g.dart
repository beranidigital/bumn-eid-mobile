// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'covid_cluster.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CovidCluster _$CovidClusterFromJson(Map<String, dynamic> json) {
  return CovidCluster(
    jumlah: json['jumlah'] as int,
    clusterBumn: json['cluster_bumn'] as String,
    wamenBumn: json['wamen_bumn'] as String,
    totalBumn: json['total_bumn'] as int,
    lastReview: json['last_review'] as String,
  );
}

Map<String, dynamic> _$CovidClusterToJson(CovidCluster instance) =>
    <String, dynamic>{
      'cluster_bumn': instance.clusterBumn,
      'wamen_bumn': instance.wamenBumn,
      'total_bumn': instance.totalBumn,
      'jumlah': instance.jumlah,
      'last_review': instance.lastReview,
    };
