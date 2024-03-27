import 'package:bumn_eid/core/api/response/response_object.dart';
import 'package:bumn_eid/core/models/csr/pk_item.dart';
import 'package:json_annotation/json_annotation.dart';

part 'pk_response.g.dart';

@JsonSerializable(createToJson: false)
class PkResponse extends ResponseObject {
  @JsonKey(name: 'success')
  final bool success;

  @JsonKey(name: 'message')
  final String message;

  @JsonKey(name: 'data')
  final List<PkItem> data;


  PkResponse({this.success, this.message, this.data});

  factory PkResponse.fromJson(Map<String, dynamic> json) =>
      _$PkResponseFromJson(json);

  static get serializer => _$PkResponseFromJson;
}