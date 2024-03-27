import 'package:bumn_eid/core/api/response/response_object.dart';
import 'package:bumn_eid/ui/components/single_list_view.dart';
import 'package:json_annotation/json_annotation.dart';

part 'legal_item.g.dart';

@JsonSerializable()
class LegalItem extends ResponseObject with SingleListItem {
  @JsonKey(name: 'id')
  final int id;

  @JsonKey(name: 'nomor_perkara')
  final String nomorPerkaraOld;

  @JsonKey(name: 'no_perkara')
  final String nomorPerkara;

  @JsonKey(name: 'no_skk')
  final String nomorSkk;

  @JsonKey(name: 'jenis_perkara')
  final String jenis_perkara;

  @JsonKey(name: 'tingkat_perkara')
  final String tingkat_perkara;

  @JsonKey(name: 'penggugat')
  final String penggugat;

  @JsonKey(name: 'tergugat')
  final String tergugat;

  @JsonKey(name: 'objek_perkara')
  final String objek_perkara;

  @JsonKey(name: 'objek_gugatan')
  final String objekGugatan;

  @JsonKey(name: 'petitum')
  final String petitum;

  @JsonKey(name: 'keterangan')
  final String keterangan;

  @JsonKey(name: 'bumn_id')
  final String bumn_id;

  @JsonKey(name: 'bumn')
  final String bumn;

  @JsonKey(name: 'kota')
  final String kota;

  @JsonKey(name: 'tempat_perkara')
  final String tempat_perkara;

  @JsonKey(name: 'progress')
  final String progress;

  @JsonKey(name: 'tahun')
  final int tahun;

  @JsonKey(name: 'id_angka')
  final String id_angka;

  @JsonKey(name: 'nama_lengkap')
  final String nama_lengkap;

  @JsonKey(name: 'nama_pendek')
  final String nama_pendek;

  @JsonKey(name: 'cluster_bumn')
  final String cluster_bumn;

  @JsonKey(name: 'wamen_bumn')
  final String wamen_bumn;

  @JsonKey(name: 'sektor_bumn')
  final String sektor_bumn;

  @JsonKey(name: 'kelas_bumn')
  final String kelas_bumn;

  @JsonKey(name: 'top_bumn')
  final String top_bumn;

  @JsonKey(name: 'skala_jabatan_bumn')
  final String skala_jabatan_bumn;

  @JsonKey(name: 'asdep')
  final String asdep;

  @JsonKey(name: 'logobumn')
  final String logobumn;

  @JsonKey(name: 'cluster_covid')
  final String cluster_covid;

  @JsonKey(name: 'wamen_covid')
  final String wamen_covid;

  @JsonKey(name: 'cluster_lama')
  final String cluster_lama;

  @JsonKey(name: 'wamen_lama')
  final String wamen_lama;

  @JsonKey(name: 'level')
  final int level;

  @JsonKey(name: 'kode_asdep')
  final String kode_asdep;

  @JsonKey(name: 'created_at')
  final String createdAt;

  @JsonKey(name: 'updated_at')
  final String updatedAt;

  LegalItem({
    this.id,
    this.nomorPerkaraOld,
    this.bumn,
    this.createdAt,
    this.keterangan,
    this.kota,
    this.tahun,
    this.bumn_id,
    this.nomorPerkara,
    this.nomorSkk,
    this.objekGugatan,
    this.penggugat,
    this.asdep,
    this.cluster_bumn,
    this.cluster_covid,
    this.cluster_lama,
    this.id_angka,
    this.tergugat,
    this.updatedAt,
    this.jenis_perkara,
    this.kelas_bumn,
    this.kode_asdep,
    this.level,
    this.logobumn,
    this.nama_lengkap,
    this.nama_pendek,
    this.objek_perkara,
    this.petitum,
    this.progress,
    this.sektor_bumn,
    this.skala_jabatan_bumn,
    this.tempat_perkara,
    this.tingkat_perkara,
    this.top_bumn,
    this.wamen_bumn,
    this.wamen_covid,
    this.wamen_lama,
  });

  factory LegalItem.fromJson(Map<String, dynamic> json) =>
      _$LegalItemFromJson(json);

  static get serializer => _$LegalItemFromJson;

  @override
  String getTitle() {
    return penggugat ?? bumn;
  }
}
