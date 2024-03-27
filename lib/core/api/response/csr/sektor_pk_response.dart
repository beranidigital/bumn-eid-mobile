import 'package:bumn_eid/core/api/response/response_object.dart';
import 'package:bumn_eid/core/models/csr/sektor_pk.dart';
import 'package:json_annotation/json_annotation.dart';

part 'sektor_pk_response.g.dart';

@JsonSerializable(createToJson: false)
class SektorPkResponse extends ResponseObject {
  @JsonKey(name: 'success')
  final bool success;

  @JsonKey(name: 'message')
  final String message;

  @JsonKey(name: 'data')
  final List<SektorPk> data;


  SektorPkResponse({this.success, this.message, this.data});

  factory SektorPkResponse.fromJson(Map<String, dynamic> json) =>
      _$SektorPkResponseFromJson(json);

  static get serializer => _$SektorPkResponseFromJson;
}