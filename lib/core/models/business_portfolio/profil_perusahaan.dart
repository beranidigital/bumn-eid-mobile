import 'package:bumn_eid/core/api/response/response_object.dart';
import 'package:bumn_eid/core/models/business_portfolio/general_company.dart';
import 'package:json_annotation/json_annotation.dart';

part 'profil_perusahaan.g.dart';

@JsonSerializable()
class ProfilPerusahaan extends ResponseObject implements GeneralCompany {

  @JsonKey(name: 'id_angka')
  final String id;

  @JsonKey(name: 'nama_perusahaan')
  final String nama;

  @JsonKey(name: 'aps_sector')
  final String apsSector;

  @JsonKey(name: 'bei_sector')
  final String beiSector;

  @JsonKey(name: 'aps_subsector')
  final String apsSubSector;

  @JsonKey(name: 'bei_subsector')
  final String beiSubSector;

  @JsonKey(name: 'alamat')
  final String alamat;

  @JsonKey(name: 'telepon')
  final String telepon;

  @JsonKey(name: 'faximile')
  final String fax;

  @JsonKey(name: 'website')
  final String website;

  @JsonKey(name: 'bidang_usaha')
  final String bidangUsaha;

  @JsonKey(name: 'isu')
  final String isu;

  @JsonKey(name: 'groupbumn')
  final String group;

  @JsonKey(name: 'logobumn')
  final String logo;

  @JsonKey(name: 'max')
  final String max;

  @JsonKey(name: 'cluster')
  final String cluster;

  @JsonKey(name: 'wamen')
  final String wamen;

  @JsonKey(name: 'perusahaan_excel')
  final String excel;

  @JsonKey(name: 'saham_pemerintah')
  final String sahamPemerintah;

  @JsonKey(name: 'saham_publik')
  final String sahamPublik;

  @JsonKey(name: 'sektor_id')
  final String sektorId;

  @JsonKey(name: 'sektor_bps')
  final String sektorBps;

  @JsonKey(name: 'proses_bisnis')
  final String bisnisProses;

  @JsonKey(name: 'nama_pendek')
  final String namaPendek;

  @JsonKey(name: 'kelas_bumn')
  final int kelasBumn;

  ProfilPerusahaan({
    this.id,
    this.nama,
    this.apsSector,
    this.beiSector,
    this.apsSubSector,
    this.beiSubSector,
    this.alamat,
    this.telepon,
    this.fax,
    this.website,
    this.bidangUsaha,
    this.isu,
    this.group,
    this.logo,
    this.max,
    this.cluster,
    this.wamen,
    this.excel,
    this.sahamPemerintah,
    this.sahamPublik,
    this.sektorId,
    this.sektorBps,
    this.bisnisProses,
    this.namaPendek,
    this.kelasBumn
  });

  factory ProfilPerusahaan.fromJson(Map<String, dynamic> json) =>
      _$ProfilPerusahaanFromJson(json);

  static get serializer => _$ProfilPerusahaanFromJson;

  Map toJson() {
    return _$ProfilPerusahaanToJson(this);
  }

  @override
  String getId() {
    return id;
  }

  @override
  String getName() {
    return nama;
  }

  @override
  String getShortName() {
    return namaPendek ?? nama;
  }

  @override
  String getCluster() {
    return cluster;
  }

  @override
  String getKelas() {
    return kelasBumn.toString();
  }

  @override
  String getWamen() {
    return wamen;
  }

  @override
  String getTitle() {
    return getShortName();
  }

}