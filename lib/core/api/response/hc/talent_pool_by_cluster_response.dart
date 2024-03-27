import 'package:bumn_eid/core/api/response/response_object.dart';
import 'package:bumn_eid/core/models/hc/talent_pool_by_cluster.dart';
import 'package:json_annotation/json_annotation.dart';

part 'talent_pool_by_cluster_response.g.dart';

@JsonSerializable(createToJson: false)
class TalentPoolByClusterResponse extends ResponseObject {
  @JsonKey(name: 'success')
  final bool success;

  @JsonKey(name: 'message')
  final String message;

  @JsonKey(name: 'data')
  final List<TalentPoolByCluster> data;

  TalentPoolByClusterResponse({this.success, this.message, this.data});

  factory TalentPoolByClusterResponse.fromJson(Map<String, dynamic> json) =>
      _$TalentPoolByClusterResponseFromJson(json);

  static get serializer => _$TalentPoolByClusterResponseFromJson;
}