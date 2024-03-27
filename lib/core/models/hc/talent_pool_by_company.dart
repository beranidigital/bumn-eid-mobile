import 'package:bumn_eid/core/api/response/response_object.dart';
import 'package:json_annotation/json_annotation.dart';

part 'talent_pool_by_company.g.dart';

@JsonSerializable(createToJson: false)
class TalentPoolByCompany extends ResponseObject {

  @JsonKey(name: 'nama_lengkap')
  final String namaLengkap;

  @JsonKey(name: 'id_angka')
  final String idAngka;

  @JsonKey(name: 'bumn')
  final String kodeBumn;

  @JsonKey(name: 'jumlah')
  final int jumlah;

  TalentPoolByCompany({this.jumlah, this.namaLengkap, this.idAngka, this.kodeBumn});

  factory TalentPoolByCompany.fromJson(Map<String, dynamic> json) =>
      _$TalentPoolByCompanyFromJson(json);

  static get serializer => _$TalentPoolByCompanyFromJson;

}