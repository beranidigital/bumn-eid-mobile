import 'package:bumn_eid/core/api/response/response_object.dart';
import 'package:bumn_eid/core/models/common/sortable.dart';
import 'package:bumn_eid/ui/pages/csr/common/penyebaran_wilayah_page/penyebaran_wilayah_page.dart';
import 'package:bumn_eid/ui/utils/widget_utils.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'pk_item.g.dart';

@JsonSerializable(createToJson: false)
class PkItem extends ResponseObject with Sortable, PenyebaranWilayahDataType {

  @JsonKey(name: 'id_angka')
  final String companyId;

  @JsonKey(name: 'nama_lengkap')
  final String nama;

  @JsonKey(name: 'tahun')
  final int tahun;

  @JsonKey(name: 'satuan')
  final String satuan;

  @JsonKey(name: 'lancar')
  final String lancar;

  @JsonKey(name: 'kurang_lancar')
  final String kurangLancar;

  @JsonKey(name: 'diragukan')
  final String diragukan;

  @JsonKey(name: 'macet')
  final String macet;

  @JsonKey(name: 'kota')
  final String kota;

  @JsonKey(name: 'propinsi')
  final String propinsi;

  @JsonKey(name: 'sektor_usaha')
  final String sektorUsaha;

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

  @JsonKey(name: 'realisasi')
  final String realisasi;

  PkItem({
     this.companyId, this.nama, this.tahun, this.satuan, this.lancar, this.kurangLancar, this.diragukan, this.macet, this.kota, this.realisasi,
     this.propinsi, this.sektorUsaha, this.cluster, this.wamen, this.sektorId, this.sektorBumn, this.kodeKategori, this.lat, this.lng
  });

  factory PkItem.fromJson(Map<String, dynamic> json) =>
      _$PkItemFromJson(json);

  static get serializer => _$PkItemFromJson;

  double totalDana() {
    if (realisasi != null) return parseDouble(realisasi);
    return parseDouble(lancar)+parseDouble(kurangLancar)+parseDouble(diragukan)+parseDouble(macet);
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
    return sektorUsaha;
  }

}

// Extension functions on NavigatorState
extension MapListExtension on Map<String, List<PkItem>> {
  Map<String, List<PkItem>> sortBasedOnValue({bool absValue = true}) {
    Map<String, List<PkItem>> output = {};
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