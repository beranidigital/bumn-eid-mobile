import 'dart:ui';

import 'package:bumn_eid/core/api/response/response_object.dart';
import 'package:bumn_eid/ui/utils/widget_utils.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'covid_review.g.dart';

@JsonSerializable()
class CovidReview extends ResponseObject {

  @JsonKey(name: 'id')
  final int id;

  @JsonKey(name: 'id_angka')
  final String idAngka;

  @JsonKey(name: 'tanggal')
  final String tanggal;

  @JsonKey(name: 'pencapaian')
  final String pencapaian;

  @JsonKey(name: 'review')
  final String review;

  @JsonKey(name: 'review_file')
  final String reviewFile;

  @JsonKey(name: 'is_review')
  final String isReview;

  @JsonKey(name: 'keterangan')
  final String keterangan;

  @JsonKey(name: 'dirawat')
  final String dirawat;

  @JsonKey(name: 'meninggal')
  final String meninggal;

  @JsonKey(name: 'sembuh')
  final String sembuh;

  @JsonKey(name: 'total')
  final String total;

  @JsonKey(name: 'campaign')
  final String campaign;

  CovidReview({
   this.idAngka, this.campaign, this.pencapaian,
    this.reviewFile, this.review, this.isReview, this.keterangan, this.id, this.tanggal, this.total, this.dirawat, this.meninggal, this.sembuh
  });

  factory CovidReview.fromJson(Map<String, dynamic> json) =>
      _$CovidReviewFromJson(json);

  Color getColor() {
    double jumlah = parseDouble(pencapaian);
    if (jumlah >= 100) return Colors.green;
    return Color(0xFF0D8B005);
  }

  static get serializer => _$CovidReviewFromJson;

}