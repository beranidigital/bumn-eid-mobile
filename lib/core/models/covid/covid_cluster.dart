import 'dart:ui';

import 'package:bumn_eid/core/api/response/response_object.dart';
import 'package:bumn_eid/ui/components/single_list_view.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'covid_cluster.g.dart';

@JsonSerializable()
class CovidCluster extends ResponseObject with SingleListItem {

  @JsonKey(name: 'cluster_bumn')
  final String clusterBumn;

  @JsonKey(name: 'wamen_bumn')
  final String wamenBumn;

  @JsonKey(name: 'total_bumn')
  final int totalBumn;

  @JsonKey(name: 'jumlah')
  final int jumlah;

  @JsonKey(name: 'last_review')
  final String lastReview;

  CovidCluster({
    this.jumlah,
    this.clusterBumn,
    this.wamenBumn,
    this.totalBumn,
    this.lastReview
  });

  factory CovidCluster.fromJson(Map<String, dynamic> json) =>
      _$CovidClusterFromJson(json);

  static get serializer => _$CovidClusterFromJson;

  @override
  String getTitle() {
    return clusterBumn;
  }

  Color getColor() {
    if (jumlah >= 100) return Colors.green;
    if (jumlah >= 80) return Color(0xFF0D8B005);
    return Colors.redAccent;
  }

}