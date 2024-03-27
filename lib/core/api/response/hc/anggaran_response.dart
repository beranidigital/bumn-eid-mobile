import 'package:bumn_eid/core/api/response/response_object.dart';
import 'package:bumn_eid/core/models/hc/anggaran.dart';
import 'package:json_annotation/json_annotation.dart';

part 'anggaran_response.g.dart';

@JsonSerializable(createToJson: false)
class AnggaranResponse extends ResponseObject {
  @JsonKey(name: 'success')
  final bool success;

  @JsonKey(name: 'message')
  final String message;

  @JsonKey(name: 'data')
  final List<Anggaran> companies;

  AnggaranResponse({this.success, this.message, this.companies});

  factory AnggaranResponse.fromJson(Map<String, dynamic> json) =>
      _$AnggaranResponseFromJson(json);

  static get serializer => _$AnggaranResponseFromJson;
}