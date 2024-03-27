import 'package:bumn_eid/core/api/response/response_object.dart';
import 'package:bumn_eid/core/models/hc/grafik_bod_kelas.dart';
import 'package:json_annotation/json_annotation.dart';

part 'grafik_bod_kelas_response.g.dart';

@JsonSerializable(createToJson: false)
class GrafikBODKelasResponse extends ResponseObject {
  @JsonKey(name: 'success')
  final bool success;

  @JsonKey(name: 'message')
  final String message;

  @JsonKey(name: "right formation")
  final Map<String, int> proposedData;

  @JsonKey(name: 'total data')
  final int totalData;

  @JsonKey(name: 'data')
  final List<GrafikBODKelas> data;

  GrafikBODKelasResponse({this.success, this.message, this.proposedData, this.totalData, this.data});

  factory GrafikBODKelasResponse.fromJson(Map<String, dynamic> json) =>
      _$GrafikBODKelasResponseFromJson(json);

  static get serializer => _$GrafikBODKelasResponseFromJson;
}