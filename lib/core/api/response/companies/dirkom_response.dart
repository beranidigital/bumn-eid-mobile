import 'package:bumn_eid/core/api/response/response_object.dart';
import 'package:bumn_eid/core/models/hc/dirkom.dart';
import 'package:json_annotation/json_annotation.dart';

part 'dirkom_response.g.dart';

@JsonSerializable(createToJson: false)
class DirkomResponse extends ResponseObject {
  @JsonKey(name: 'success')
  final bool success;

  @JsonKey(name: 'message')
  final String message;

  @JsonKey(name: 'data')
  final List<Dirkom> data;


  DirkomResponse({this.success, this.message, this.data});

  factory DirkomResponse.fromJson(Map<String, dynamic> json) =>
      _$DirkomResponseFromJson(json);

  static get serializer => _$DirkomResponseFromJson;
}