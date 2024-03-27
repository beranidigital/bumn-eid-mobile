import 'package:bumn_eid/core/api/response/response_object.dart';
import 'package:json_annotation/json_annotation.dart';

part 'bod1_talent_jabatan.g.dart';

@JsonSerializable(createToJson: false)
class BOD1TalentJabatan extends ResponseObject {

  @JsonKey(name: 'JABATAN')
  final String jabatan;

  @JsonKey(name: 'URAIAN')
  final String uraian;

  @JsonKey(name: 'WAKTU')
  final String waktu;

  @JsonKey(name: 'PERUSAHAAN')
  final String perusahaan;

  @JsonKey(name: 'MULAI')
  final String mulai;

  @JsonKey(name: 'AKHIR')
  final String akhir;

  BOD1TalentJabatan({
    this.jabatan,
    this.uraian,
    this.waktu,
    this.perusahaan,
    this.mulai,
    this.akhir
  });

  factory BOD1TalentJabatan.fromJson(Map<String, dynamic> json) =>
      _$BOD1TalentJabatanFromJson(json);

  static get serializer => _$BOD1TalentJabatanFromJson;

}