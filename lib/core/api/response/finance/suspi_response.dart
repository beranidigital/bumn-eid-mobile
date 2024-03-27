import 'package:bumn_eid/core/api/response/response_object.dart';
import 'package:bumn_eid/core/models/finance/suspi_deni.dart';
import 'package:json_annotation/json_annotation.dart';

part 'suspi_response.g.dart';

@JsonSerializable(createToJson: false)
class SuspiResponse extends ResponseObject {
  @JsonKey(name: 'success')
  final bool success;

  @JsonKey(name: 'message')
  final String message;

  @JsonKey(name: 'data')
  final List<SuspiDeni> data;

  SuspiResponse({this.success, this.message, this.data});

  factory SuspiResponse.fromJson(Map<String, dynamic> json) =>
      _$SuspiResponseFromJson(json);

  static get serializer => _$SuspiResponseFromJson;
}