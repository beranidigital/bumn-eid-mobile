import 'package:bumn_eid/core/api/response/response_object.dart';
import 'package:json_annotation/json_annotation.dart';

part 'csr_company.g.dart';

@JsonSerializable()
class CsrCompany extends ResponseObject {

  @JsonKey(name: 'id_angka')
  final String id;

  @JsonKey(name: 'nama_lengkap')
  final String nama;

  @JsonKey(name: 'nama_pendek')
  final String namaPendek;

  CsrCompany({
    this.id,
    this.nama,
    this.namaPendek,
  });

  factory CsrCompany.fromJson(Map<String, dynamic> json) =>
      _$CsrCompanyFromJson(json);

  static get serializer => _$CsrCompanyFromJson;

}