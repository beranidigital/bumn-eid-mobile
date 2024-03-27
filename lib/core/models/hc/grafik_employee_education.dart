import 'package:bumn_eid/core/api/response/response_object.dart';
import 'package:json_annotation/json_annotation.dart';

part 'grafik_employee_education.g.dart';

@JsonSerializable(createToJson: false)
class GrafikEmployeeEducation extends ResponseObject {

  @JsonKey(name: 'id_angka')
  final String id;

  @JsonKey(name: 'nama_lengkap')
  final String namaLengkap;

  @JsonKey(name: 'nama_pendek')
  final String namaPendek;

  @JsonKey(name: 'tahun')
  final int tahun;

  @JsonKey(name: 's_3')
  final int s3;

  @JsonKey(name: 's_2')
  final int s2;

  @JsonKey(name: 's_1')
  final int s1;

  @JsonKey(name: 'd_3')
  final int d3;

  @JsonKey(name: 'd_2')
  final int d2;

  @JsonKey(name: 'd_1')
  final int d1;

  @JsonKey(name: 'sma')
  final int sma;

  @JsonKey(name: 'smp')
  final int smp;

  @JsonKey(name: 'sd')
  final int sd;

  GrafikEmployeeEducation({this.id, this.namaLengkap, this.namaPendek, this.tahun, this.s3, this.s2, this.s1,
      this.d3, this.d2, this.d1, this.sma, this.smp, this.sd});

  factory GrafikEmployeeEducation.fromJson(Map<String, dynamic> json) =>
      _$GrafikEmployeeEducationFromJson(json);

  static get serializer => _$GrafikEmployeeEducationFromJson;

}