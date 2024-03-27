import 'package:bumn_eid/core/api/response/response_object.dart';
import 'package:json_annotation/json_annotation.dart';

part 'project_progress.g.dart';

@JsonSerializable()
class ProjectProgress extends ResponseObject {

  @JsonKey(name: 'id')
  final int id;

  @JsonKey(name: 'id_projek')
  final int idProject;

  @JsonKey(name: 'tanggal')
  final String tanggal;

  @JsonKey(name: 'progress_percent')
  final String progress;

  @JsonKey(name: 'uraian')
  final String description;

  @JsonKey(name: 'status')
  final String status;

  @JsonKey(name: 'kode_status')
  final String statusCode;

  ProjectProgress({
    this.id,
    this.idProject,
    this.tanggal,
    this.progress,
    this.description,
    this.status,
    this.statusCode,
  });

  factory ProjectProgress.fromJson(Map<String, dynamic> json) =>
      _$ProjectProgressFromJson(json);

  static get serializer => _$ProjectProgressFromJson;

}