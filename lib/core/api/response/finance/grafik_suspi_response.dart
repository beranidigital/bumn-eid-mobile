import 'package:bumn_eid/core/api/response/response_object.dart';
import 'package:bumn_eid/core/models/finance/grafik_suspi.dart';
import 'package:json_annotation/json_annotation.dart';

part 'grafik_suspi_response.g.dart';

@JsonSerializable(createToJson: false)
class GrafikSuspiResponse extends ResponseObject {
  @JsonKey(name: 'success')
  final bool success;

  @JsonKey(name: 'message')
  final String message;

  @JsonKey(name: 'data')
  final List<GrafikSuspi> data;

  GrafikSuspiResponse({this.success, this.message, this.data});

  factory GrafikSuspiResponse.fromJson(Map<String, dynamic> json) =>
      _$GrafikSuspiResponseFromJson(json);

  static get serializer => _$GrafikSuspiResponseFromJson;
}