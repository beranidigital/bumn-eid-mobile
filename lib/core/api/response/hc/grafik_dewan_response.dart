import 'package:bumn_eid/core/api/response/response_object.dart';
import 'package:bumn_eid/core/models/hc/grafik_dewan_komisaris_proposed.dart';
import 'package:bumn_eid/core/models/hc/grafik_dewan_komisaris_realization.dart';
import 'package:json_annotation/json_annotation.dart';

part 'grafik_dewan_response.g.dart';

@JsonSerializable(createToJson: false)
class GrafikDewanResponse extends ResponseObject {
  @JsonKey(name: 'success')
  final bool success;

  @JsonKey(name: 'message')
  final String message;

  @JsonKey(name: 'total data')
  final int totalData;

  @JsonKey(name: 'proposed formation')
  final List<GrafikDewanKomisarisProposed> proposedData;

  @JsonKey(name: 'data')
  final List<GrafikDewanKomisarisRealization> realizationData;

  GrafikDewanResponse({this.success, this.message, this.totalData, this.proposedData, this.realizationData});

  factory GrafikDewanResponse.fromJson(Map<String, dynamic> json) =>
      _$GrafikDewanResponseFromJson(json);

  static get serializer => _$GrafikDewanResponseFromJson;
}