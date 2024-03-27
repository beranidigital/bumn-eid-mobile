import 'package:bumn_eid/core/api/response/response_object.dart';
import 'package:bumn_eid/core/models/hc/talent_pool_by_class.dart';
import 'package:json_annotation/json_annotation.dart';

part 'talent_pool_by_class_response.g.dart';

@JsonSerializable(createToJson: false)
class TalentPoolByClassResponse extends ResponseObject {
  @JsonKey(name: 'success')
  final bool success;

  @JsonKey(name: 'message')
  final String message;

  @JsonKey(name: 'data')
  final List<TalentPoolByClass> data;

  TalentPoolByClassResponse({this.success, this.message, this.data});

  factory TalentPoolByClassResponse.fromJson(Map<String, dynamic> json) =>
      _$TalentPoolByClassResponseFromJson(json);

  static get serializer => _$TalentPoolByClassResponseFromJson;
}