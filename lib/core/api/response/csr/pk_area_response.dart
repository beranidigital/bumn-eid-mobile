import 'package:bumn_eid/core/api/response/response_object.dart';
import 'package:bumn_eid/core/models/csr/pk_item_area.dart';
import 'package:json_annotation/json_annotation.dart';

part 'pk_area_response.g.dart';

@JsonSerializable(createToJson: false)
class PkAreaResponse extends ResponseObject {
  @JsonKey(name: 'success')
  final bool success;

  @JsonKey(name: 'message')
  final String message;

  @JsonKey(name: 'data')
  final List<PkItemArea> data;


  PkAreaResponse({this.success, this.message, this.data});

  factory PkAreaResponse.fromJson(Map<String, dynamic> json) =>
      _$PkAreaResponseFromJson(json);

  static get serializer => _$PkAreaResponseFromJson;
}