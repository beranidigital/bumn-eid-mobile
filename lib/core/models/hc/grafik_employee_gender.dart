import 'package:bumn_eid/core/api/response/response_object.dart';
import 'package:json_annotation/json_annotation.dart';

part 'grafik_employee_gender.g.dart';

@JsonSerializable(createToJson: false)
class GrafikEmployeeGender extends ResponseObject {

  @JsonKey(name: 'id_angka')
  final String id;

  @JsonKey(name: 'nama_lengkap')
  final String namaLengkap;

  @JsonKey(name: 'nama_pendek')
  final String namaPendek;

  @JsonKey(name: 'tahun')
  final int tahun;

  @JsonKey(name: 'laki_laki')
  final int laki;

  @JsonKey(name: 'perempuan')
  final int perempuan;

  GrafikEmployeeGender({this.id, this.namaLengkap, this.namaPendek, this.tahun, this.laki, this.perempuan});

  factory GrafikEmployeeGender.fromJson(Map<String, dynamic> json) =>
      _$GrafikEmployeeGenderFromJson(json);

  static get serializer => _$GrafikEmployeeGenderFromJson;

}