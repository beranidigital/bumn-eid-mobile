import 'package:bumn_eid/core/api/response/response_object.dart';
import 'package:bumn_eid/core/models/common/anak_perusahaan_deni.dart';
import 'package:bumn_eid/core/models/internal/summary_internal.dart';
import 'package:json_annotation/json_annotation.dart';

part 'summary_internal_response.g.dart';

@JsonSerializable(createToJson: false)
class SummaryInternalResponse extends ResponseObject {
  @JsonKey(name: 'success')
  final bool success;

  @JsonKey(name: 'message')
  final String message;

  @JsonKey(name: 'data')
  final SummaryInternal data;

  SummaryInternalResponse({
    this.success,
    this.message,
    this.data,
  });

  factory SummaryInternalResponse.fromJson(Map<String, dynamic> json) =>
      _$SummaryInternalResponseFromJson(json);

  static get serializer => _$SummaryInternalResponseFromJson;
}
