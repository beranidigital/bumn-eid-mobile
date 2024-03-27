import 'package:bumn_eid/core/api/response/response_object.dart';
import 'package:bumn_eid/core/models/internal/jenis_kelamin.dart';
import 'package:json_annotation/json_annotation.dart';

part 'summary_pendidikan.g.dart';

@JsonSerializable()
class SummaryPendidikan extends ResponseObject {
  @JsonKey(name: 'under_30')
  final int under30;

  @JsonKey(name: 'between_30_39')
  final int between3039;

  @JsonKey(name: 'between_40_49')
  final int between4049;

  @JsonKey(name: 'above_50')
  final int above50;

  SummaryPendidikan({
    this.under30,
    this.between3039,
    this.between4049,
    this.above50,
  });

  factory SummaryPendidikan.fromJson(Map<String, dynamic> json) =>
      _$SummaryPendidikanFromJson(json);

  static get serializer => _$SummaryPendidikanFromJson;
}
