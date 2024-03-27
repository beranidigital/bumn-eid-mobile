import 'package:bumn_eid/core/api/response/response_object.dart';
import 'package:bumn_eid/core/models/covid/covid_summary.dart';
import 'package:bumn_eid/core/models/covid/covid_summary_review.dart';
import 'package:json_annotation/json_annotation.dart';

part 'covid_summary_response.g.dart';

@JsonSerializable(createToJson: false)
class CovidSummaryResponse extends ResponseObject {
  @JsonKey(name: 'success')
  final bool success;

  @JsonKey(name: 'message')
  final String message;

  @JsonKey(name: 'data')
  final CovidSummary data;

  @JsonKey(name: 'data_review')
  final List<CovidSummaryReview> review;

  CovidSummaryResponse({this.success, this.message, this.data, this.review});

  factory CovidSummaryResponse.fromJson(Map<String, dynamic> json) =>
      _$CovidSummaryResponseFromJson(json);

  static get serializer => _$CovidSummaryResponseFromJson;
}