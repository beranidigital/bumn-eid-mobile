import 'package:bumn_eid/core/api/response/response_object.dart';
import 'package:bumn_eid/core/models/hc/grafik_dewan_komisaris_kelas_detailed.dart';
import 'package:bumn_eid/core/models/hc/grafik_dewan_komisaris_kelas_detailed_proposed.dart';
import 'package:json_annotation/json_annotation.dart';

part 'grafik_dewan_kelas_detailed_response.g.dart';

@JsonSerializable(createToJson: false)
class GrafikDewanKelasDetailedResponse extends ResponseObject {
  @JsonKey(name: 'success')
  final bool success;

  @JsonKey(name: 'message')
  final String message;

  @JsonKey(name: 'total data')
  final int totalData;

  @JsonKey(name: 'data')
  final List<GrafikDewanKomisarisKelasDetailed> data;

  @JsonKey(name: 'proposed formation')
  final List<GrafikDewanKomisarisKelasDetailedProposed> proposedData;

  GrafikDewanKelasDetailedResponse({this.success, this.message, this.totalData, this.data, this.proposedData});

  factory GrafikDewanKelasDetailedResponse.fromJson(Map<String, dynamic> json) =>
      _$GrafikDewanKelasDetailedResponseFromJson(json);

  static get serializer => _$GrafikDewanKelasDetailedResponseFromJson;
}