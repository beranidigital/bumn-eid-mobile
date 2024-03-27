import 'package:bumn_eid/core/api/response/response_object.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'talent_pool_item.g.dart';

@JsonSerializable(createToJson: false)
class TalentPoolItem extends ResponseObject {

  @JsonKey(name: 'jabatan')
  final String jabatan;

  @JsonKey(name: 'nik')
  final String nik;

  @JsonKey(name: 'nama')
  final String nama;

  @JsonKey(name: 'bumn')
  final String kodeBumn;

  @JsonKey(name: 'busnm')
  final String namaPerusahaan;

  @JsonKey(name: 'kategori')
  final String kategori;

  @JsonKey(name: 'id_angka')
  final String companyId;

  @JsonKey(name: 'status')
  final String status;

  @JsonKey(name: 'nilai_domestic')
  final String nilaiDomestic;

  @JsonKey(name: 'nilai_global')
  final String nilaiGlobal;

  @JsonKey(name: 'hasil_domestic')
  final String hasilDomestic;

  @JsonKey(name: 'hasil_global')
  final String hasilGlobal;

  @JsonKey(name: 'lainnya_tclust')
  final String lainnyatclust;

  @JsonKey(name: 'mobility')
  final String mobility;

  @JsonKey(name: 'feedback')
  final String feedback;

  @JsonKey(name: 'id')
  final int id;

  @JsonKey(name: 'cluster_bumn')
  final String clusterBumn;

  @JsonKey(name: 'wamen_bumn')
  final String wamenBumn;

  @JsonKey(name: 'sektor_bumn')
  final String sektorBumn;

  @JsonKey(name: 'kelas_bumn')
  final String kelasBumn;

  @JsonKey(name: 'top_bumn')
  final String topBumn;

  @JsonKey(name: 'skala_jabatan_bumn')
  final String skalaJabatanBumn;

  @JsonKey(name: 'asdep')
  final String asdep;

  @JsonKey(name: 'mobility_kategori')
  final String mobilityKategori;

  TalentPoolItem({this.kodeBumn, this.clusterBumn, this.kelasBumn, this.companyId, this.id, this.nama, this.jabatan, this.nik,
  this.kategori, this.status, this.asdep, this.topBumn, this.wamenBumn, this.namaPerusahaan, this.sektorBumn, this.feedback, this.hasilDomestic,
  this.hasilGlobal, this.lainnyatclust, this.mobility, this.nilaiDomestic, this.nilaiGlobal, this.skalaJabatanBumn,
  this.mobilityKategori});

  factory TalentPoolItem.fromJson(Map<String, dynamic> json) =>
      _$TalentPoolItemFromJson(json);

  static get serializer => _$TalentPoolItemFromJson;

  Color getColor() {
    switch (status.toLowerCase()) {
      case "ready":
        return Color(0xFF56CC70);
      case "eligible":
        return Color(0xFF6FB4F5);
      case "nominated":
        return Color(0xFFDAA520);
      case "selected":
        return Color(0xFFA9A9A9);
      default:
        return Color(0xFF56CC70);
    }
  }

  String getImagePath() {
    switch (status.toLowerCase()) {
      case "ready":
        return "res/images/ready.png";
      case "eligible":
        return "res/images/eligible.png";
      case "nominated":
        return "res/images/nominated.png";
      case "selected":
        return "res/images/selected.png";
      default:
        return "res/images/ready.png";
    }
  }

}