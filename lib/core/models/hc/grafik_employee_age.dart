import 'package:bumn_eid/core/api/response/response_object.dart';
import 'package:json_annotation/json_annotation.dart';

part 'grafik_employee_age.g.dart';

@JsonSerializable(createToJson: false)
class GrafikEmployeeAge extends ResponseObject {

  @JsonKey(name: 'id_angka')
  final String id;

  @JsonKey(name: 'nama_lengkap')
  final String namaLengkap;

  @JsonKey(name: 'nama_pendek')
  final String namaPendek;

  @JsonKey(name: 'tahun')
  final int tahun;

  @JsonKey(name: 'n_umur_a')
  final int diatas56;

  @JsonKey(name: 'n_umur_b')
  final int antara4556;

  @JsonKey(name: 'n_umur_c')
  final int antara3645;

  @JsonKey(name: 'n_umur_d')
  final int antara2635;

  @JsonKey(name: 'n_umur_e')
  final int dibawah25;

  GrafikEmployeeAge({this.id, this.namaLengkap, this.namaPendek, this.tahun, this.diatas56, this.antara4556, this.antara3645,
      this.antara2635, this.dibawah25});

  factory GrafikEmployeeAge.fromJson(Map<String, dynamic> json) =>
      _$GrafikEmployeeAgeFromJson(json);

  static get serializer => _$GrafikEmployeeAgeFromJson;

}