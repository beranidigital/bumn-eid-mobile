import 'package:bumn_eid/core/api/response/response_object.dart';
import 'package:bumn_eid/ui/components/single_list_view.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'covid_company_list.g.dart';

@JsonSerializable()
class CovidCompanyList extends ResponseObject with SingleListItem {

  @JsonKey(name: 'nama_lengkap')
  final String namaLengkap;

  @JsonKey(name: 'id_angka')
  final String idAngka;

  @JsonKey(name: 'bumn')
  final String bumn;

  @JsonKey(name: 'jumlah')
  final int jumlah;

  @JsonKey(name: 'last_review')
  final String lastReview;

  CovidCompanyList({
    this.jumlah,
    this.idAngka,
    this.namaLengkap,
    this.bumn,
    this.lastReview
  });

  factory CovidCompanyList.fromJson(Map<String, dynamic> json) =>
      _$CovidCompanyListFromJson(json);

  static get serializer => _$CovidCompanyListFromJson;

  @override
  String getTitle() {
    return namaLengkap;
  }

  Color getColor() {
    if (jumlah >= 100) return Colors.green;
    if (jumlah >= 80) return Color(0xFF0D8B005);
    return Colors.redAccent;
  }

}