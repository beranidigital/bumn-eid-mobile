import 'package:bumn_eid/core/api/response/response_object.dart';
import 'package:json_annotation/json_annotation.dart';

part 'bod1_cluster.g.dart';

@JsonSerializable(createToJson: false)
class BOD1Cluster extends ResponseObject {

  @JsonKey(name: 'cluster_bumn')
  final String cluster;

  @JsonKey(name: 'jumlah')
  final int jumlahBOD1;

  BOD1Cluster({this.cluster, this.jumlahBOD1});

  factory BOD1Cluster.fromJson(Map<String, dynamic> json) =>
      _$BOD1ClusterFromJson(json);

  static get serializer => _$BOD1ClusterFromJson;

}