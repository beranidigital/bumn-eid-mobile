import 'package:bumn_eid/core/api/response/response_object.dart';
import 'package:json_annotation/json_annotation.dart';

part 'grafik_dewan_komisaris_cluster.g.dart';

@JsonSerializable(createToJson: false)
class GrafikDewanKomisarisCluster extends ResponseObject {

  @JsonKey(name: 'cluster_bumn')
  final String cluster;

  @JsonKey(name: 'jumlah')
  final int jumlah;

  GrafikDewanKomisarisCluster({this.cluster, this.jumlah});

  factory GrafikDewanKomisarisCluster.fromJson(Map<String, dynamic> json) =>
      _$GrafikDewanKomisarisClusterFromJson(json);

  static get serializer => _$GrafikDewanKomisarisClusterFromJson;

}