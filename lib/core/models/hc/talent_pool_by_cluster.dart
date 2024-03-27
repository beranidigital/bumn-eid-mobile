import 'package:bumn_eid/core/api/response/response_object.dart';
import 'package:json_annotation/json_annotation.dart';

part 'talent_pool_by_cluster.g.dart';

@JsonSerializable(createToJson: false)
class TalentPoolByCluster extends ResponseObject {

  @JsonKey(name: 'cluster_bumn')
  final String clusterBumn;

  @JsonKey(name: 'wamen_bumn')
  final String wamenBumn;

  @JsonKey(name: 'jumlah')
  final int jumlah;

  TalentPoolByCluster({this.jumlah, this.wamenBumn, this.clusterBumn});

  factory TalentPoolByCluster.fromJson(Map<String, dynamic> json) =>
      _$TalentPoolByClusterFromJson(json);

  static get serializer => _$TalentPoolByClusterFromJson;

}