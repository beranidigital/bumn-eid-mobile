import 'dart:ui';

import 'package:bumn_eid/core/api/response/response_object.dart';
import 'package:bumn_eid/ui/components/custom_bar_chart.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'legal_summary_bumn.g.dart';

@JsonSerializable()
class LegalSummaryBumn extends ResponseObject {
  @JsonKey(name: 'bumn_id')
  final String bumn_id;

  @JsonKey(name: 'bumn')
  final String bumn;

  @JsonKey(name: 'total_perkara')
  final int total_perkara;

  LegalSummaryBumn({
    this.total_perkara,this.bumn,this.bumn_id,
  });

  factory LegalSummaryBumn.fromJson(Map<String, dynamic> json) =>
      _$LegalSummaryBumnFromJson(json);

  static get serializer => _$LegalSummaryBumnFromJson;
}
