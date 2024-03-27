import 'package:bumn_eid/core/api/response/response_object.dart';
import 'package:bumn_eid/core/models/hc/grafik_dewan_komisaris_grouped.dart';
import 'package:json_annotation/json_annotation.dart';

part 'grafik_dewan_grouped_response.g.dart';

@JsonSerializable(createToJson: false)
class GrafikDewanGroupedResponse extends ResponseObject {
  @JsonKey(name: 'success')
  final bool success;

  @JsonKey(name: 'message')
  final String message;

  @JsonKey(name: 'total data')
  final int totalData;

  @JsonKey(name: 'data')
  final List<GrafikDewanKomisarisGrouped> data;

  GrafikDewanGroupedResponse({this.success, this.message, this.totalData, this.data});

  factory GrafikDewanGroupedResponse.fromJson(Map<String, dynamic> json) =>
      _$GrafikDewanGroupedResponseFromJson(json);

  static get serializer => _$GrafikDewanGroupedResponseFromJson;
}