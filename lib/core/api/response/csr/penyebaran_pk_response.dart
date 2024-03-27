import 'package:bumn_eid/core/api/response/response_object.dart';
import 'package:bumn_eid/core/models/csr/pk_item.dart';
import 'package:json_annotation/json_annotation.dart';

part 'penyebaran_pk_response.g.dart';

@JsonSerializable(createToJson: false)
class PenyebaranPkResponse extends ResponseObject {
  @JsonKey(name: 'success')
  final bool success;

  @JsonKey(name: 'message')
  final String message;

  @JsonKey(name: 'data')
  final List<PkItem> data;


  PenyebaranPkResponse({this.success, this.message, this.data});

  factory PenyebaranPkResponse.fromJson(Map<String, dynamic> json) =>
      _$PenyebaranPkResponseFromJson(json);

  static get serializer => _$PenyebaranPkResponseFromJson;
}