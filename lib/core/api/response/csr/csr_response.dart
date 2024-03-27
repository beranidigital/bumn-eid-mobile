import 'package:bumn_eid/core/api/response/response_object.dart';
import 'package:bumn_eid/core/models/csr/csr_item.dart';
import 'package:json_annotation/json_annotation.dart';

part 'csr_response.g.dart';

@JsonSerializable(createToJson: false)
class CsrResponse extends ResponseObject {
  @JsonKey(name: 'success')
  final bool success;

  @JsonKey(name: 'message')
  final String message;

  @JsonKey(name: 'data')
  final List<CsrItem> data;


  CsrResponse({this.success, this.message, this.data});

  factory CsrResponse.fromJson(Map<String, dynamic> json) =>
      _$CsrResponseFromJson(json);

  static get serializer => _$CsrResponseFromJson;
}