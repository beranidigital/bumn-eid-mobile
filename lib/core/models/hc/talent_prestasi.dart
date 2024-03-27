import 'package:bumn_eid/core/api/response/response_object.dart';
import 'package:json_annotation/json_annotation.dart';

part 'talent_prestasi.g.dart';

@JsonSerializable()
class TalentPrestasi extends ResponseObject {

  @JsonKey(name: 'i_user')
  final int idUser;

  @JsonKey(name: 'e_year')
  final String tahun;

  @JsonKey(name: 'e_penyelenggara')
  final String organizer;

  @JsonKey(name: 'n_prestasi')
  final String namaPrestasi;

  @JsonKey(name: 'e_desc')
  final String deskripsi;

  @JsonKey(name: 'n_bidang')
  final String bidang;

  @JsonKey(name: 'n_lingkup')
  final String lingkup;

  TalentPrestasi({
    this.idUser,
    this.tahun,
    this.namaPrestasi,
    this.organizer,
    this.deskripsi,
    this.bidang,
    this.lingkup
  });

  factory TalentPrestasi.fromJson(Map<String, dynamic> json) =>
      _$TalentPrestasiFromJson(json);

  static get serializer => _$TalentPrestasiFromJson;

}