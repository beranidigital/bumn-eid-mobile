import 'package:bumn_eid/core/api/response/response_object.dart';
import 'package:bumn_eid/core/models/covid/covid_company_list.dart';
import 'package:bumn_eid/core/models/covid/covid_detail.dart';
import 'package:bumn_eid/core/models/covid/covid_review.dart';
import 'package:json_annotation/json_annotation.dart';

part 'covid_detail_response.g.dart';

@JsonSerializable(createToJson: false)
class CovidDetailResponse extends ResponseObject {
  @JsonKey(name: 'success')
  final bool success;

  @JsonKey(name: 'message')
  final String message;

  @JsonKey(name: 'data')
  final List<CovidDetail> data;

  @JsonKey(name: 'data_review')
  final List<CovidReview> review;


  CovidDetailResponse({this.success, this.message, this.data, this.review});

  factory CovidDetailResponse.fromJson(Map<String, dynamic> json) =>
      _$CovidDetailResponseFromJson(json);

  static get serializer => _$CovidDetailResponseFromJson;
}