import 'package:bumn_eid/core/api/response/response_object.dart';
import 'package:bumn_eid/ui/components/bigger_custom_table.dart';
import 'package:bumn_eid/ui/components/custom_bar_chart.dart';
import 'package:bumn_eid/ui/utils/widget_utils.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:quiver/core.dart';

part 'kinerja_perusahaan.g.dart';

@JsonSerializable()
class KinerjaPerusahaan extends ResponseObject with BarChartDataType, BiggerCustomTableData {

  @JsonKey(name: 'id_angka')
  final String id;

  @JsonKey(name: 'nama_lengkap')
  final String namaPerusahaan;

  @JsonKey(name: 'tahun')
  final int tahun;

  @JsonKey(name: 'jumlah')
  final String jumlah;

  @JsonKey(name: 'satuan')
  final String satuan;

  @JsonKey(name: 'jenis_akun')
  final String jenisAkun;

  @JsonKey(name: 'cluster_bumn')
  final String clusterBumn;

  @JsonKey(name: 'wamen_bumn')
  final String wamenBumn;

  @JsonKey(name: 'kategori')
  final String category;

  KinerjaPerusahaan({
    this.id,
    this.namaPerusahaan,
    this.tahun,
    this.jumlah,
    this.satuan,
    this.jenisAkun,
    this.clusterBumn,
    this.wamenBumn,
    this.category,
  });

  factory KinerjaPerusahaan.fromJson(Map<String, dynamic> json) =>
      _$KinerjaPerusahaanFromJson(json);

  static get serializer => _$KinerjaPerusahaanFromJson;

  Map toJson() {
    return _$KinerjaPerusahaanToJson(this);
  }

  bool operator ==(o) => o is KinerjaPerusahaan && namaPerusahaan == o.namaPerusahaan && jenisAkun == o.jenisAkun && tahun == o.tahun;

  int get hashCode => hash3(namaPerusahaan.hashCode, jenisAkun.hashCode, tahun.hashCode);

  @override
  Color getColor() {
    return Color(0xff44A9A8);
  }

  @override
  int getX() {
    return tahun;
  }

  @override
  double getY() {
    return parseDouble(jumlah);
  }

  @override
  double getJumlah() {
    return parseDouble(jumlah);
  }

  @override
  String getTahun() {
    return tahun.toString();
  }

}