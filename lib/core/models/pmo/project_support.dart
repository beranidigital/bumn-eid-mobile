import 'package:bumn_eid/core/api/response/response_object.dart';
import 'package:json_annotation/json_annotation.dart';

part 'project_support.g.dart';

@JsonSerializable()
class ProjectSupport extends ResponseObject {

  @JsonKey(name: 'id')
  final int id;

  @JsonKey(name: 'id_projek')
  final int idProject;

  @JsonKey(name: 'dukungan')
  final String support;

  @JsonKey(name: 'kendala')
  final String kendala;

  @JsonKey(name: 'kategori')
  final String kategori;

  @JsonKey(name: 'kode_kategori')
  final String kodeKategori;

  ProjectSupport({
    this.id,
    this.idProject,
    this.support,
    this.kendala,
    this.kategori,
    this.kodeKategori,
  });

  factory ProjectSupport.fromJson(Map<String, dynamic> json) =>
      _$ProjectSupportFromJson(json);

  static get serializer => _$ProjectSupportFromJson;

}