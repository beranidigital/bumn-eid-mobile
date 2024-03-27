import 'package:bumn_eid/core/api/response/response_object.dart';
import 'package:bumn_eid/core/models/hc/grafik_bod_cluster.dart';
import 'package:json_annotation/json_annotation.dart';

part 'grafik_bod_cluster_response.g.dart';

@JsonSerializable(createToJson: false)
class GrafikBODClusterResponse extends ResponseObject {
  @JsonKey(name: 'success')
  final bool success;

  @JsonKey(name: 'message')
  final String message;

  @JsonKey(name: 'total data')
  final int totalData;

  @JsonKey(name: 'data')
  final List<GrafikBODCluster> data;

  GrafikBODClusterResponse({this.success, this.message, this.totalData, this.data});

  factory GrafikBODClusterResponse.fromJson(Map<String, dynamic> json) =>
      _$GrafikBODClusterResponseFromJson(json);

  static get serializer => _$GrafikBODClusterResponseFromJson;
}