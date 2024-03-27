import 'package:bumn_eid/core/api/response/response_object.dart';
import 'package:bumn_eid/core/models/hc/grafik_potret_kerja_detailed.dart';
import 'package:json_annotation/json_annotation.dart';

part 'grafik_potret_tugas_detailed_response.g.dart';

@JsonSerializable(createToJson: false)
class GrafikPotretTugasDetailedResponse extends ResponseObject {
  @JsonKey(name: 'success')
  final bool success;

  @JsonKey(name: 'message')
  final String message;

  @JsonKey(name: 'total_data')
  final int totalData;

  @JsonKey(name: 'data')
  final List<GrafikPotretTugasDetailed> data;

  GrafikPotretTugasDetailedResponse({this.success, this.message, this.totalData, this.data});

  factory GrafikPotretTugasDetailedResponse.fromJson(Map<String, dynamic> json) =>
      _$GrafikPotretTugasDetailedResponseFromJson(json);

  static get serializer => _$GrafikPotretTugasDetailedResponseFromJson;
}