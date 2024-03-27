import 'package:bumn_eid/core/api/response/response_object.dart';
import 'package:bumn_eid/core/models/hc/grafik_bod_kelas_detailed.dart';
import 'package:bumn_eid/core/models/hc/grafik_bod_kelas_detailed_proposed.dart';
import 'package:json_annotation/json_annotation.dart';

part 'grafik_bod_kelas_detailed_response.g.dart';

@JsonSerializable(createToJson: false)
class GrafikBODKelasDetailedResponse extends ResponseObject {
  @JsonKey(name: 'success')
  final bool success;

  @JsonKey(name: 'message')
  final String message;

  @JsonKey(name: 'total data')
  final int totalData;

  @JsonKey(name: 'data')
  final List<GrafikBODKelasDetailed> data;

  @JsonKey(name: 'proposed formation')
  final List<GrafikBODKelasDetailedProposed> proposedData;

  GrafikBODKelasDetailedResponse({this.success, this.message, this.totalData, this.data, this.proposedData});

  factory GrafikBODKelasDetailedResponse.fromJson(Map<String, dynamic> json) =>
      _$GrafikBODKelasDetailedResponseFromJson(json);

  static get serializer => _$GrafikBODKelasDetailedResponseFromJson;
}