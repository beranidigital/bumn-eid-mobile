import 'package:bumn_eid/core/api/response/response_object.dart';
import 'package:json_annotation/json_annotation.dart';

part 'project_milestone.g.dart';

@JsonSerializable()
class ProjectMilestone extends ResponseObject {

  @JsonKey(name: 'id')
  final int id;

  @JsonKey(name: 'id_projek')
  final int idProject;

  @JsonKey(name: 'bulan')
  final String bulan;

  @JsonKey(name: 'tahun')
  final String tahun;

  @JsonKey(name: 'uraian')
  final String description;

  ProjectMilestone({
    this.id,
    this.idProject,
    this.bulan,
    this.tahun,
    this.description,
  });

  factory ProjectMilestone.fromJson(Map<String, dynamic> json) =>
      _$ProjectMilestoneFromJson(json);

  static get serializer => _$ProjectMilestoneFromJson;

}