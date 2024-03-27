import 'package:bumn_eid/core/api/response/response_object.dart';
import 'package:bumn_eid/core/models/hc/grafik_bod_realization.dart';
import 'package:json_annotation/json_annotation.dart';

part 'grafik_bod_response.g.dart';

@JsonSerializable(createToJson: false)
class GrafikBODResponse extends ResponseObject {
  @JsonKey(name: 'success')
  final bool success;

  @JsonKey(name: 'message')
  final String message;

  @JsonKey(name: 'total data')
  final int totalData;

  @JsonKey(name: 'data')
  final List<GrafikBODRealization> realizationData;

  GrafikBODResponse({this.success, this.message, this.totalData, this.realizationData});

  factory GrafikBODResponse.fromJson(Map<String, dynamic> json) =>
      _$GrafikBODResponseFromJson(json);

  static get serializer => _$GrafikBODResponseFromJson;
}