import 'package:bumn_eid/core/api/response/response_object.dart';
import 'package:bumn_eid/core/models/common/sortable.dart';
import 'package:bumn_eid/ui/utils/widget_utils.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'csr_item.g.dart';

@JsonSerializable()
class CsrItem extends ResponseObject with Sortable {

  @JsonKey(name: 'id_angka')
  final String companyId;

  @JsonKey(name: 'nama_lengkap')
  final String nama;

  @JsonKey(name: 'tahun')
  final int tahun;

  @JsonKey(name: 'periode_nama')
  final String periodeNama;

  @JsonKey(name: 'bentuk_csr')
  final String bentukCsr;

  @JsonKey(name: 'dana_csr')
  final String danaCsr;

  @JsonKey(name: 'kota')
  final String kota;

  @JsonKey(name: 'propinsi')
  final String propinsi;

  @JsonKey(name: 'cluster_bumn')
  final String cluster;

  @JsonKey(name: 'wamen_bumn')
  final String wamen;

  @JsonKey(name: 'sektor_id')
  final String sektorId;

  @JsonKey(name: 'sektor_bumn')
  final String sektorBumn;

  @JsonKey(name: 'lat')
  final String lat;

  @JsonKey(name: 'lng')
  final String lng;

  CsrItem({
    this.companyId, this.nama, this.tahun, this.kota, this.periodeNama, this.bentukCsr, this.danaCsr,
    this.propinsi, this.cluster, this.wamen, this.sektorId, this.sektorBumn, this.lat, this.lng
  });

  factory CsrItem.fromJson(Map<String, dynamic> json) =>
      _$CsrItemFromJson(json);

  static get serializer => _$CsrItemFromJson;

  double totalDana() {
    return parseDouble(danaCsr);
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

}