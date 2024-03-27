import 'package:bumn_eid/core/api/response/response_object.dart';
import 'package:bumn_eid/core/models/business_portfolio/summary.dart';
import 'package:json_annotation/json_annotation.dart';

part 'summary_response.g.dart';

@JsonSerializable(createToJson: false)
class SummaryResponse extends ResponseObject {
  @JsonKey(name: 'success')
  final bool success;

  @JsonKey(name: 'message')
  final String message;

  @JsonKey(name: 'data')
  final List<Summary> data;


  SummaryResponse({this.success, this.message, this.data});

  factory SummaryResponse.fromJson(Map<String, dynamic> json) =>
      _$SummaryResponseFromJson(json);

  static get serializer => _$SummaryResponseFromJson;
}