import 'package:bumn_eid/core/api/response/response_object.dart';
import 'package:bumn_eid/core/models/pmo/project_item.dart';
import 'package:bumn_eid/core/models/pmo/project_milestone.dart';
import 'package:bumn_eid/core/models/pmo/project_progress.dart';
import 'package:bumn_eid/core/models/pmo/project_support.dart';
import 'package:bumn_eid/core/models/pmo/project_team.dart';
import 'package:json_annotation/json_annotation.dart';

part 'project_detail_response.g.dart';

@JsonSerializable(createToJson: false)
class ProjectDetailResponse extends ResponseObject {
  @JsonKey(name: 'success')
  final bool success;

  @JsonKey(name: 'message')
  final String message;

  @JsonKey(name: 'project')
  final List<ProjectItem> project;

  @JsonKey(name: 'progress')
  final List<ProjectProgress> progress;

  @JsonKey(name: 'milestone')
  final List<ProjectMilestone> milestone;

  @JsonKey(name: 'supports')
  final List<ProjectSupport> support;

  @JsonKey(name: 'team')
  final List<ProjectTeam> team;

  ProjectDetailResponse({this.success, this.message, this.project, this.progress, this.milestone, this.support, this.team});

  factory ProjectDetailResponse.fromJson(Map<String, dynamic> json) =>
      _$ProjectDetailResponseFromJson(json);

  static get serializer => _$ProjectDetailResponseFromJson;
}