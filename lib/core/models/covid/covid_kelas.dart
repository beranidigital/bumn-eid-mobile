import 'package:bumn_eid/core/api/response/response_object.dart';
import 'package:bumn_eid/ui/components/single_list_view.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'covid_kelas.g.dart';

@JsonSerializable()
class CovidKelas extends ResponseObject with SingleListItem {

  @JsonKey(name: 'kelas_bumn')
  final String kelasBumn;

  @JsonKey(name: 'total_bumn')
  final int totalBumn;

  @JsonKey(name: 'jumlah')
  final int jumlah;

  CovidKelas({
    this.jumlah,
    this.kelasBumn,
    this.totalBumn,
  });

  factory CovidKelas.fromJson(Map<String, dynamic> json) =>
      _$CovidKelasFromJson(json);

  static get serializer => _$CovidKelasFromJson;

  @override
  String getTitle() {
    return "Kelas $kelasBumn";
  }

  Color getColor() {
    if (jumlah >= 100) return Colors.green;
    if (jumlah >= 80) return Color(0xFF0D8B005);
    return Colors.redAccent;
  }

}