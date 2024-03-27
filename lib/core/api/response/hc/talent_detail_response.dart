import 'package:bumn_eid/core/api/response/response_object.dart';
import 'package:bumn_eid/core/models/hc/talent_detail.dart';
import 'package:json_annotation/json_annotation.dart';

part 'talent_detail_response.g.dart';

@JsonSerializable(createToJson: false)
class TalentDetailResponse extends ResponseObject {
  @JsonKey(name: 'success')
  final bool success;

  @JsonKey(name: 'message')
  final String message;

  @JsonKey(name: 'total data')
  final int totalData;

  @JsonKey(name: 'data')
  final List<TalentDetail> data;

  TalentDetailResponse({this.success, this.message, this.totalData, this.data});

  factory TalentDetailResponse.fromJson(Map<String, dynamic> json) =>
      _$TalentDetailResponseFromJson(json);

  static get serializer => _$TalentDetailResponseFromJson;
}