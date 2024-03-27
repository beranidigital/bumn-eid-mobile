import 'package:bumn_eid/core/api/response/response_object.dart';
import 'package:bumn_eid/core/models/hc/grafik_dewan_komisaris_cluster.dart';
import 'package:bumn_eid/core/models/hc/grafik_dewan_komisaris_grouped.dart';
import 'package:json_annotation/json_annotation.dart';

part 'grafik_dewan_cluster_response.g.dart';

@JsonSerializable(createToJson: false)
class GrafikDewanClusterResponse extends ResponseObject {
  @JsonKey(name: 'success')
  final bool success;

  @JsonKey(name: 'message')
  final String message;

  @JsonKey(name: 'total data')
  final int totalData;

  @JsonKey(name: 'data')
  final List<GrafikDewanKomisarisCluster> data;

  GrafikDewanClusterResponse({this.success, this.message, this.totalData, this.data});

  factory GrafikDewanClusterResponse.fromJson(Map<String, dynamic> json) =>
      _$GrafikDewanClusterResponseFromJson(json);

  static get serializer => _$GrafikDewanClusterResponseFromJson;
}