import 'package:bumn_eid/core/api/response/response_object.dart';
import 'package:bumn_eid/core/models/hc/bod1_cluster.dart';
import 'package:json_annotation/json_annotation.dart';

part 'bod1_cluster_response.g.dart';

@JsonSerializable(createToJson: false)
class BOD1ClusterResponse extends ResponseObject {
  @JsonKey(name: 'success')
  final bool success;

  @JsonKey(name: 'message')
  final String message;

  @JsonKey(name: 'data')
  final List<BOD1Cluster> companies;

  BOD1ClusterResponse({this.success, this.message, this.companies});

  factory BOD1ClusterResponse.fromJson(Map<String, dynamic> json) =>
      _$BOD1ClusterResponseFromJson(json);

  static get serializer => _$BOD1ClusterResponseFromJson;
}