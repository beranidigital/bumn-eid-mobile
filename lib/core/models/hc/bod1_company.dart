import 'package:bumn_eid/core/api/response/response_object.dart';
import 'package:json_annotation/json_annotation.dart';

part 'bod1_company.g.dart';

@JsonSerializable(createToJson: false)
class BOD1Company extends ResponseObject {

  @JsonKey(name: 'id_angka')
  final String id;

  @JsonKey(name: 'nama_lengkap')
  final String companyName;

  @JsonKey(name: 'bumn')
  final String bumn;

  @JsonKey(name: 'jumlah')
  final int jumlahBOD1;

  BOD1Company({this.id, this.companyName, this.bumn, this.jumlahBOD1});

  factory BOD1Company.fromJson(Map<String, dynamic> json) =>
      _$BOD1CompanyFromJson(json);

  static get serializer => _$BOD1CompanyFromJson;

}