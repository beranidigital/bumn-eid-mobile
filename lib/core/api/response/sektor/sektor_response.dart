import 'package:bumn_eid/core/api/response/response_object.dart';
import 'package:bumn_eid/core/models/business_portfolio/sektor.dart';
import 'package:json_annotation/json_annotation.dart';

part 'sektor_response.g.dart';

@JsonSerializable()
class SektorResponse extends ResponseObject {
  @JsonKey(name: 'success')
  final bool success;

  @JsonKey(name: 'message')
  final String message;

  @JsonKey(name: 'data')
  final List<Sektor> data;


  SektorResponse({this.success, this.message, this.data});

  factory SektorResponse.fromJson(Map<String, dynamic> json) =>
      _$SektorResponseFromJson(json);

  static get serializer => _$SektorResponseFromJson;
}