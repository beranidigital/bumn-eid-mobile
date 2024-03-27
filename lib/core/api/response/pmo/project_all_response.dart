import 'package:bumn_eid/core/api/response/response_object.dart';
import 'package:bumn_eid/core/models/pmo/project_item.dart';
import 'package:json_annotation/json_annotation.dart';

part 'project_all_response.g.dart';

@JsonSerializable(createToJson: false)
class ProjectAllResponse extends ResponseObject {
  @JsonKey(name: 'success')
  final bool success;

  @JsonKey(name: 'message')
  final String message;

  @JsonKey(name: 'data')
  final List<ProjectItem> data;

  ProjectAllResponse({this.success, this.message, this.data});

  factory ProjectAllResponse.fromJson(Map<String, dynamic> json) =>
      _$ProjectAllResponseFromJson(json);

  static get serializer => _$ProjectAllResponseFromJson;
}