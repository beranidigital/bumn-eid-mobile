import 'package:bumn_eid/core/api/response/response_object.dart';
import 'package:bumn_eid/core/models/common/sortable.dart';
import 'package:bumn_eid/ui/pages/csr/common/penyebaran_wilayah_page/penyebaran_wilayah_page.dart';
import 'package:bumn_eid/ui/utils/widget_utils.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'bl_item.g.dart';

@JsonSerializable(createToJson: false)
class BlItem extends ResponseObject with Sortable, PenyebaranWilayahDataType {

  @JsonKey(name: 'id_angka')
  final String companyId;

  @JsonKey(name: 'nama_lengkap')
  final String nama;

  @JsonKey(name: 'tahun')
  final int tahun;

  @JsonKey(name: 'satuan')
  final String satuan;

  @JsonKey(name: 'realisasi')
  final String realisasi;

  @JsonKey(name: 'kota')
  final String kota;

  @JsonKey(name: 'propinsi')
  final String propinsi;

  @JsonKey(name: 'jenis_bantuan')
  final String jenisBantuan;

  @JsonKey(name: 'cluster_bumn')
  final String cluster;

  @JsonKey(name: 'wamen_bumn')
  final String wamen;

  @JsonKey(name: 'sektor_id')
  final String sektorId;

  @JsonKey(name: 'sektor_bumn')
  final String sektorBumn;

  @JsonKey(name: 'kode_kategori')
  final int kodeKategori;

  @JsonKey(name: 'lat')
  final String lat;

  @JsonKey(name: 'lng')
  final String lng;

  BlItem({
    this.companyId, this.nama, this.tahun, this.satuan, this.realisasi, this.kota,
    this.propinsi, this.jenisBantuan, this.cluster, this.wamen, this.sektorId, this.sektorBumn, this.kodeKategori, this.lat, this.lng
  });

  factory BlItem.fromJson(Map<String, dynamic> json) =>
      _$BlItemFromJson(json);

  static get serializer => _$BlItemFromJson;

  double totalDana() {
    return parseDouble(realisasi);
  }

  @override
  num getNumber() {
    return totalDana();
  }

  @override
  LatLng getLatLng() {
    return LatLng(
      parseDouble(lat),
      parseDouble(lng),
    );
  }

  @override
  String getPropinsi() {
    return propinsi;
  }

  @override
  int getTahun() {
    return tahun;
  }

  @override
  num getTotal() {
    return totalDana();
  }

  @override
  String getJenis() {
    return jenisBantuan;
  }

}

// Extension functions on NavigatorState
extension MapListExtension on Map<String, List<BlItem>> {
  Map<String, List<BlItem>> sortBasedOnValue({bool absValue = true}) {
    Map<String, List<BlItem>> output = {};
    List<String> sortedKeys = this.keys.toList()..sort((a,b) {
      try {
        num bNum = this[b].fold(0, (x,y) => x+y.totalDana().truncate());
        if (absValue) bNum = bNum.abs();
        num aNum = this[a].fold(0, (x,y) => x+y.totalDana().truncate());
        if (absValue) aNum = aNum.abs();
        return bNum.compareTo(aNum);
      } catch (ex) {
        return 0;
      }
    });
    sortedKeys.forEach((key) => output[key] = this[key]);
    return output;
  }
}