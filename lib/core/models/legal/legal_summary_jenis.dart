import 'dart:ui';

import 'package:bumn_eid/core/api/response/response_object.dart';
import 'package:bumn_eid/ui/components/custom_bar_chart.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'legal_summary_jenis.g.dart';

@JsonSerializable()
class LegalSummaryJenis extends ResponseObject {
  @JsonKey(name: 'arbitrase')
  final int arbitrase;

  @JsonKey(name: 'judicial_review')
  final int judicial_review;

  @JsonKey(name: 'Perdata')
  final int Perdata;

  LegalSummaryJenis({
    this.arbitrase,
    this.judicial_review,
    this.Perdata,
  });

  factory LegalSummaryJenis.fromJson(Map<String, dynamic> json) =>
      _$LegalSummaryJenisFromJson(json);

  static get serializer => _$LegalSummaryJenisFromJson;
}
