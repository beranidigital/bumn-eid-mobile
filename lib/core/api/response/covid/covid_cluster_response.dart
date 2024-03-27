import 'package:bumn_eid/core/api/response/response_object.dart';
import 'package:bumn_eid/core/models/covid/covid_cluster.dart';
import 'package:json_annotation/json_annotation.dart';

part 'covid_cluster_response.g.dart';

@JsonSerializable(createToJson: false)
class CovidClusterResponse extends ResponseObject {
  @JsonKey(name: 'success')
  final bool success;

  @JsonKey(name: 'message')
  final String message;

  @JsonKey(name: 'data')
  final List<CovidCluster> data;


  CovidClusterResponse({this.success, this.message, this.data});

  factory CovidClusterResponse.fromJson(Map<String, dynamic> json) =>
      _$CovidClusterResponseFromJson(json);

  static get serializer => _$CovidClusterResponseFromJson;
}