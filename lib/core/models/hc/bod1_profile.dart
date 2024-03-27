import 'package:bumn_eid/core/api/response/response_object.dart';
import 'package:json_annotation/json_annotation.dart';

part 'bod1_profile.g.dart';

@JsonSerializable(createToJson: false)
class BOD1Profile extends ResponseObject {

  @JsonKey(name: 'jabatan')
  final String jabatan;

  @JsonKey(name: 'id_angka')
  final String companyId;

  @JsonKey(name: 'nik')
  final String nik;

  @JsonKey(name: 'nama')
  final String nama;

  @JsonKey(name: 'bumn')
  final String bumn;

  @JsonKey(name: 'busnm')
  final String busnm;

  @JsonKey(name: 'kategori')
  final String kategori;

  @JsonKey(name: 'status')
  final String status;

  BOD1Profile({this.jabatan, this.nik, this.companyId, this.nama, this.bumn, this.busnm, this.kategori, this.status});

  factory BOD1Profile.fromJson(Map<String, dynamic> json) =>
      _$BOD1ProfileFromJson(json);

  static get serializer => _$BOD1ProfileFromJson;

}