import 'package:bumn_eid/core/api/response/response_object.dart';
import 'package:bumn_eid/core/models/csr/bl_item.dart';
import 'package:json_annotation/json_annotation.dart';

part 'penyebaran_bl_response.g.dart';

@JsonSerializable(createToJson: false)
class PenyebaranBlResponse extends ResponseObject {
  @JsonKey(name: 'success')
  final bool success;

  @JsonKey(name: 'message')
  final String message;

  @JsonKey(name: 'data')
  final List<BlItem> data;


  PenyebaranBlResponse({this.success, this.message, this.data});

  factory PenyebaranBlResponse.fromJson(Map<String, dynamic> json) =>
      _$PenyebaranBlResponseFromJson(json);

  static get serializer => _$PenyebaranBlResponseFromJson;
}