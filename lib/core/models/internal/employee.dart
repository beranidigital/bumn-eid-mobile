import 'package:bumn_eid/core/api/response/response_object.dart';
import 'package:json_annotation/json_annotation.dart';

part 'employee.g.dart';

@JsonSerializable()
class Employee extends ResponseObject {
  @JsonKey(name: 'id')
  final int id;

  @JsonKey(name: 'pegawai_id')
  final String idPegawai;

  @JsonKey(name: 'nip')
  final String nip;

  @JsonKey(name: 'pegawai_nama')
  final String nama;

  @JsonKey(name: 'jenis_kelamin')
  final String jenisKelamin;

  @JsonKey(name: 'tempat_lahir')
  final String tempatLahir;

  @JsonKey(name: 'tgl_lahir')
  final DateTime tanggalLahir;

  @JsonKey(name: 'agama')
  final String agama;

  @JsonKey(name: 'status_nikah')
  final String statusNikah;

  @JsonKey(name: 'status_wn')
  final String statusWargaNegara;

  @JsonKey(name: 'status_pegawai')
  final String statusPegawai;

  @JsonKey(name: 'jabatan')
  final String jabatan;

  @JsonKey(name: 'pref_jabatan')
  final String prefJabatan;

  @JsonKey(name: 'pendidikan')
  final String pendidikan;

  @JsonKey(name: 'eselon_1_id')
  final int idEselon1;

  @JsonKey(name: 'eselon_1')
  final String eselon1;

  @JsonKey(name: 'eselon_2_id')
  final int idEselon2;

  @JsonKey(name: 'eselon_2')
  final int eselon2;

  @JsonKey(name: 'created_at')
  final int createdAt;

  @JsonKey(name: 'updated_at')
  final int updatedAt;

  Employee({
    this.jenisKelamin,
    this.id,
    this.createdAt,
    this.agama,
    this.eselon1,
    this.eselon2,
    this.idEselon1,
    this.idEselon2,
    this.idPegawai,
    this.jabatan,
    this.nama,
    this.nip,
    this.pendidikan,
    this.prefJabatan,
    this.statusNikah,
    this.statusPegawai,
    this.statusWargaNegara,
    this.tanggalLahir,
    this.tempatLahir,
    this.updatedAt,
  });

  factory Employee.fromJson(Map<String, dynamic> json) =>
      _$EmployeeFromJson(json);

  static get serializer => _$EmployeeFromJson;
}
