import 'package:bumn_eid/core/api/response/response_object.dart';
import 'package:bumn_eid/core/models/csr/bl_item_area.dart';
import 'package:json_annotation/json_annotation.dart';

part 'bl_area_response.g.dart';

@JsonSerializable(createToJson: false)
class BlAreaResponse extends ResponseObject {
  @JsonKey(name: 'success')
  final bool success;

  @JsonKey(name: 'message')
  final String message;

  @JsonKey(name: 'data')
  final List<BlItemArea> data;


  BlAreaResponse({this.success, this.message, this.data});

  factory BlAreaResponse.fromJson(Map<String, dynamic> json) =>
      _$BlAreaResponseFromJson(json);

  static get serializer => _$BlAreaResponseFromJson;
}