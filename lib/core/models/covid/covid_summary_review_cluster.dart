import 'dart:ui';

import 'package:bumn_eid/core/api/response/response_object.dart';
import 'package:bumn_eid/ui/utils/widget_utils.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'covid_summary_review_cluster.g.dart';

@JsonSerializable()
class CovidSummaryReviewCluster extends ResponseObject {

  @JsonKey(name: 'id')
  final int id;

  @JsonKey(name: 'nama_lengkap')
  final String nama;

  @JsonKey(name: 'is_review')
  final String isReview;

  @JsonKey(name: 'review_file')
  final List<String> reviewFile;

  @JsonKey(name: 'tanggal')
  final String tanggalReview;

  @JsonKey(name: 'pencapaian')
  final String pencapaian;

  @JsonKey(name: 'keterangan')
  final String keterangan;

  @JsonKey(name: 'timeline_all')
  final int timelineAll;

  @JsonKey(name: 'timeline_red')
  final int timelineRed;

  @JsonKey(name: 'timeline_yellow')
  final int timelineYellow;

  @JsonKey(name: 'timeline_green')
  final int timelineGreen;

  CovidSummaryReviewCluster({
    this.tanggalReview,
    this.keterangan,
    this.pencapaian,
    this.id,
    this.nama,
    this.reviewFile,
    this.isReview,
    this.timelineAll,
    this.timelineRed,
    this.timelineYellow,
    this.timelineGreen
  });

  Color getColor() {
    double jumlah = parseDouble(pencapaian);
    if (jumlah >= 100) return Colors.green;
    return Color(0xFF0D8B005);
  }

  factory CovidSummaryReviewCluster.fromJson(Map<String, dynamic> json) =>
      _$CovidSummaryReviewClusterFromJson(json);

  static get serializer => _$CovidSummaryReviewClusterFromJson;

}