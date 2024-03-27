import 'package:bumn_eid/core/api/response/response_object.dart';
import 'package:bumn_eid/core/models/common/sortable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'suspi.g.dart';

@JsonSerializable(createToJson: false)
class Suspi extends ResponseObject with Sortable {

  @JsonKey(name: 'id')
  final int id;

  @JsonKey(name: 'id_angka')
  final String companyId;

  @JsonKey(name: 'nama_lengkap')
  final String namaPerusahaan;

  @JsonKey(name: 'tahun')
  final int tahun;
  
  @JsonKey(name: 'dana_pihak_tiga')
  final int danaPihakTiga;

  @JsonKey(name: 'pinjaman')
  final int pinjaman;

  @JsonKey(name: 'surat_utang')
  final int suratUtang;

  @JsonKey(name: 'cadangan_teknis_asuransi')
  final int cadanganTeknisAsuransi;

  @JsonKey(name: 'utang_usaha')
  final int utangUsaha;

  @JsonKey(name: 'liabilitas_lain')
  final int liabilitasLain;

  @JsonKey(name: 'satuan')
  final String satuan;

  @JsonKey(name: 'cluster_bumn')
  final String cluster;

  @JsonKey(name: 'wamen_bumn')
  final String wamen;

  @JsonKey(name: 'kelas_bumn')
  final String kelas;

  Suspi({this.companyId, this.namaPerusahaan, this.tahun, this.cadanganTeknisAsuransi, this.kelas, this.cluster,
    this.id, this.wamen, this.satuan,
    this.danaPihakTiga, this.liabilitasLain, this.pinjaman, this.suratUtang, this.utangUsaha});

  factory Suspi.fromJson(Map<String, dynamic> json) =>
      _$SuspiFromJson(json);

  static get serializer => _$SuspiFromJson;

  @override
  num getNumber() {
    return cadanganTeknisAsuransi + danaPihakTiga + liabilitasLain + pinjaman + suratUtang + utangUsaha;
  }

}