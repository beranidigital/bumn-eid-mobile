import 'package:bumn_eid/core/api/response/response_object.dart';
import 'package:bumn_eid/core/models/common/anak_perusahaan_deni.dart';
import 'package:bumn_eid/core/models/hc/drop_talent_item.dart';
import 'package:bumn_eid/core/models/hc/talent_pool_item.dart';
import 'package:json_annotation/json_annotation.dart';

part 'drop_talent_item_response.g.dart';

@JsonSerializable(createToJson: false)
class DropTalentItemResponse extends ResponseObject {
  @JsonKey(name: 'success')
  final bool success;

  @JsonKey(name: 'message')
  final String message;

  @JsonKey(name: 'data')
  final List<TalentPoolItem> pejabat;

  DropTalentItemResponse({this.success, this.message, this.pejabat});

  factory DropTalentItemResponse.fromJson(Map<String, dynamic> json) =>
      _$DropTalentItemResponseFromJson(json);

  static get serializer => _$DropTalentItemResponseFromJson;
}