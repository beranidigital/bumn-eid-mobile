import 'package:bumn_eid/core/api/response/response_object.dart';
import 'package:bumn_eid/core/models/business_portfolio/general_company.dart';
import 'package:json_annotation/json_annotation.dart';

part 'hc_company.g.dart';

@JsonSerializable()
class HcCompany extends ResponseObject implements GeneralCompany {

  @JsonKey(name: 'id_angka')
  final String id;

  @JsonKey(name: 'nama_lengkap')
  final String nama;

  @JsonKey(name: 'nama_pendek')
  final String namaPendek;

  @JsonKey(name: 'jumlah_direksi')
  final int jumlahDireksi;

  @JsonKey(name: 'jumlah_komisaris')
  final int jumlahKomisaris;

  @JsonKey(name: 'cluster_bumn')
  final String cluster;

  @JsonKey(name: 'kelas_bumn')
  final String kelas;

  @JsonKey(name: 'wamen_bumn')
  final String wamen;

  HcCompany({
    this.id,
    this.nama,
    this.namaPendek,
    this.jumlahDireksi,
    this.jumlahKomisaris,
    this.cluster,
    this.kelas,
    this.wamen
  });

  factory HcCompany.fromJson(Map<String, dynamic> json) =>
      _$HcCompanyFromJson(json);

  static get serializer => _$HcCompanyFromJson;

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
    return kelas;
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