import 'package:bumn_eid/core/api/response/response_object.dart';
import 'package:bumn_eid/core/models/csr/pkbl.dart';
import 'package:json_annotation/json_annotation.dart';

part 'pkbl_response.g.dart';

@JsonSerializable(createToJson: false)
class PkblResponse extends ResponseObject {
  @JsonKey(name: 'success')
  final bool success;

  @JsonKey(name: 'message')
  final String message;

  @JsonKey(name: 'data')
  final List<Pkbl> data;


  PkblResponse({this.success, this.message, this.data});

  factory PkblResponse.fromJson(Map<String, dynamic> json) =>
      _$PkblResponseFromJson(json);

  static get serializer => _$PkblResponseFromJson;
}