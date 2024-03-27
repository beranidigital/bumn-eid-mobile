import 'package:bumn_eid/core/api/response/response_object.dart';
import 'package:bumn_eid/core/models/hc/talent_pool_item.dart';
import 'package:json_annotation/json_annotation.dart';

part 'talent_pool_item_response.g.dart';

@JsonSerializable(createToJson: false)
class TalentPoolItemResponse extends ResponseObject {
  @JsonKey(name: 'success')
  final bool success;

  @JsonKey(name: 'message')
  final String message;

  @JsonKey(name: 'data')
  final List<TalentPoolItem> data;

  TalentPoolItemResponse({this.success, this.message, this.data});

  factory TalentPoolItemResponse.fromJson(Map<String, dynamic> json) =>
      _$TalentPoolItemResponseFromJson(json);

  static get serializer => _$TalentPoolItemResponseFromJson;
}