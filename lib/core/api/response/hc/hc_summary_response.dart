import 'package:bumn_eid/core/api/response/response_object.dart';
import 'package:bumn_eid/core/models/hc/hc_summary.dart';
import 'package:json_annotation/json_annotation.dart';

part 'hc_summary_response.g.dart';

@JsonSerializable(createToJson: false)
class HcSummaryResponse extends ResponseObject {
  @JsonKey(name: 'success')
  final bool success;

  @JsonKey(name: 'message')
  final String message;

  @JsonKey(name: 'data')
  final HcSummary data;

  HcSummaryResponse({this.success, this.message, this.data});

  factory HcSummaryResponse.fromJson(Map<String, dynamic> json) =>
      _$HcSummaryResponseFromJson(json);

  static get serializer => _$HcSummaryResponseFromJson;
}