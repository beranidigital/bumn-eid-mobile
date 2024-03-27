import 'package:bumn_eid/core/api/response/response_object.dart';
import 'package:bumn_eid/core/models/legal/legal_item.dart';
import 'package:json_annotation/json_annotation.dart';

part 'legal_response_single.g.dart';

@JsonSerializable()
class LegalResponseSingle extends ResponseObject {
  @JsonKey(name: 'success')
  final bool success;

  @JsonKey(name: 'message')
  final String message;

  @JsonKey(name: 'data')
  final LegalItem data;

  LegalResponseSingle({this.success, this.message, this.data});

  factory LegalResponseSingle.fromJson(Map<String, dynamic> json) =>
      _$LegalResponseSingleFromJson(json);

  static get serializer => _$LegalResponseSingleFromJson;
}
