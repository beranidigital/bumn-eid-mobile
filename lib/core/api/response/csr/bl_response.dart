import 'package:bumn_eid/core/api/response/response_object.dart';
import 'package:bumn_eid/core/models/csr/bl_item.dart';
import 'package:json_annotation/json_annotation.dart';

part 'bl_response.g.dart';

@JsonSerializable(createToJson: false)
class BlResponse extends ResponseObject {
  @JsonKey(name: 'success')
  final bool success;

  @JsonKey(name: 'message')
  final String message;

  @JsonKey(name: 'data')
  final List<BlItem> data;


  BlResponse({this.success, this.message, this.data});

  factory BlResponse.fromJson(Map<String, dynamic> json) =>
      _$BlResponseFromJson(json);

  static get serializer => _$BlResponseFromJson;
}