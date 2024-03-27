import 'package:bumn_eid/core/api/response/response_object.dart';
import 'package:bumn_eid/core/models/legal/legal_summary.dart';
import 'package:bumn_eid/core/models/legal/legal_summary_data.dart';
import 'package:json_annotation/json_annotation.dart';

part 'legal_summary_response.g.dart';

@JsonSerializable()
class LegalSummaryResponse extends ResponseObject {
  @JsonKey(name: 'success')
  final bool success;

  @JsonKey(name: 'message')
  final String message;

  @JsonKey(name: 'data')
  final LegalSummaryData data;

  LegalSummaryResponse({this.success, this.message, this.data});

  factory LegalSummaryResponse.fromJson(Map<String, dynamic> json) =>
      _$LegalSummaryResponseFromJson(json);

  static get serializer => _$LegalSummaryResponseFromJson;
}
