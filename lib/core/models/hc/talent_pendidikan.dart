import 'package:bumn_eid/core/api/response/response_object.dart';
import 'package:json_annotation/json_annotation.dart';

part 'talent_pendidikan.g.dart';

@JsonSerializable()
class TalentPendidikan extends ResponseObject {

  @JsonKey(name: 'i_user')
  final int idUser;

  @JsonKey(name: 'i_pendidikan')
  final int idPendidikan;

  @JsonKey(name: 'n_education')
  final String degree;

  @JsonKey(name: 'n_pendidikan')
  final String instansi;

  @JsonKey(name: 'e_jurusan')
  final String jurusan;

  @JsonKey(name: 'e_program')
  final String program;

  @JsonKey(name: 'i_mtahun')
  final int tahunMulai;

  @JsonKey(name: 'i_ltahun')
  final int tahunSelesai;

  @JsonKey(name: 'e_alamat')
  final String alamat;

  @JsonKey(name: 'e_telp')
  final String telepon;

  @JsonKey(name: 'e_kepala')
  final String kepalaInstansi;

  TalentPendidikan({
    this.idUser,
    this.alamat,
    this.telepon,
    this.degree,
    this.idPendidikan,
    this.instansi,
    this.jurusan,
    this.kepalaInstansi,
    this.program,
    this.tahunMulai,
    this.tahunSelesai
  });

  factory TalentPendidikan.fromJson(Map<String, dynamic> json) =>
      _$TalentPendidikanFromJson(json);

  static get serializer => _$TalentPendidikanFromJson;

}