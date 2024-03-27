import 'package:bumn_eid/core/api/response/response_object.dart';
import 'package:json_annotation/json_annotation.dart';

part 'grafik_bod_cluster.g.dart';

@JsonSerializable(createToJson: false)
class GrafikBODCluster extends ResponseObject {

  @JsonKey(name: 'cluster_bumn')
  final String cluster;

  @JsonKey(name: 'jumlah')
  final int jumlah;

  GrafikBODCluster({this.cluster, this.jumlah});

  factory GrafikBODCluster.fromJson(Map<String, dynamic> json) =>
      _$GrafikBODClusterFromJson(json);

  static get serializer => _$GrafikBODClusterFromJson;

}