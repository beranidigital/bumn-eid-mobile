import 'package:bumn_eid/core/api/response/response_object.dart';
import 'package:bumn_eid/core/models/covid/covid_company_list.dart';
import 'package:bumn_eid/core/models/covid/covid_summary_review_cluster.dart';
import 'package:json_annotation/json_annotation.dart';

part 'covid_company_list_response.g.dart';

@JsonSerializable(createToJson: false)
class CovidCompanyListResponse extends ResponseObject {
  @JsonKey(name: 'success')
  final bool success;

  @JsonKey(name: 'message')
  final String message;

  @JsonKey(name: 'data')
  final List<CovidCompanyList> data;

  @JsonKey(name: 'data_review')
  final List<CovidSummaryReviewCluster> review;


  CovidCompanyListResponse({this.success, this.message, this.data, this.review});

  factory CovidCompanyListResponse.fromJson(Map<String, dynamic> json) =>
      _$CovidCompanyListResponseFromJson(json);

  static get serializer => _$CovidCompanyListResponseFromJson;
}