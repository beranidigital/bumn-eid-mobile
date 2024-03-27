import 'package:bumn_eid/core/api/response/response_object.dart';
import 'package:bumn_eid/core/models/legal/legal_item.dart';
import 'package:json_annotation/json_annotation.dart';

part 'legal_response.g.dart';

@JsonSerializable()
class LegalResponse extends ResponseObject {
  @JsonKey(name: 'success')
  final bool success;

  @JsonKey(name: 'message')
  final String message;

  @JsonKey(name: 'data')
  final List<LegalItem> data;


  LegalResponse({this.success, this.message, this.data});

  factory LegalResponse.fromJson(Map<String, dynamic> json) =>
      _$LegalResponseFromJson(json);

  static get serializer => _$LegalResponseFromJson;
}