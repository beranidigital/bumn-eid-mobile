import 'package:bumn_eid/core/api/response/response_object.dart';
import 'package:json_annotation/json_annotation.dart';

part 'project_team.g.dart';

@JsonSerializable()
class ProjectTeam extends ResponseObject {

  @JsonKey(name: 'id')
  final int id;

  @JsonKey(name: 'id_projek')
  final int idProject;

  @JsonKey(name: 'jenis_tim')
  final String jenisTim;

  @JsonKey(name: 'nama_jabatan')
  final String namaJabatan;

  @JsonKey(name: 'instansi')
  final String instansi;

  @JsonKey(name: 'pic')
  final String pic;

  ProjectTeam({
    this.id,
    this.idProject,
    this.jenisTim,
    this.namaJabatan,
    this.instansi,
    this.pic
  });

  factory ProjectTeam.fromJson(Map<String, dynamic> json) =>
      _$ProjectTeamFromJson(json);

  static get serializer => _$ProjectTeamFromJson;

}