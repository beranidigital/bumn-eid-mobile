import 'package:bumn_eid/core/api/response/response_object.dart';
import 'package:json_annotation/json_annotation.dart';

part 'grafik_employee_demografi.g.dart';

@JsonSerializable(createToJson: false)
class GrafikEmployeeDemografi extends ResponseObject {

  @JsonKey(name: 'id_angka')
  final String id;

  @JsonKey(name: 'nama_lengkap')
  final String namaLengkap;

  @JsonKey(name: 'nama_pendek')
  final String namaPendek;

  @JsonKey(name: 'tahun')
  final int tahun;

  @JsonKey(name: 'pegawai')
  final int totalPegawai;

  @JsonKey(name: 'p_kontrak')
  final int pkwt;

  @JsonKey(name: 'p_tetap')
  final int pkwtt;

  @JsonKey(name: 'p_organik')
  final int pegawaiOrganik;

  @JsonKey(name: 'p_terampil')
  final int pegawaiTerampil;

  GrafikEmployeeDemografi({this.id, this.namaLengkap, this.namaPendek, this.tahun, this.totalPegawai, this.pkwt, this.pkwtt,
      this.pegawaiOrganik, this.pegawaiTerampil});

  factory GrafikEmployeeDemografi.fromJson(Map<String, dynamic> json) =>
      _$GrafikEmployeeDemografiFromJson(json);

  static get serializer => _$GrafikEmployeeDemografiFromJson;

}