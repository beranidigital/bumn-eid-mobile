import 'package:bumn_eid/core/api/response/response_object.dart';
import 'package:bumn_eid/core/models/hc/grafik_dewan_komisaris_cluster.dart';
import 'package:bumn_eid/core/models/hc/grafik_dewan_komisaris_grouped.dart';
import 'package:bumn_eid/core/models/hc/grafik_dewan_komisaris_kelas.dart';
import 'package:json_annotation/json_annotation.dart';

part 'grafik_dewan_kelas_response.g.dart';

@JsonSerializable(createToJson: false)
class GrafikDewanKelasResponse extends ResponseObject {
  @JsonKey(name: 'success')
  final bool success;

  @JsonKey(name: 'message')
  final String message;

  @JsonKey(name: 'right formation')
  final Map<String, int> rightFormation;

  @JsonKey(name: 'total data')
  final int totalData;

  @JsonKey(name: 'data')
  final List<GrafikDewanKomisarisKelas> data;

  GrafikDewanKelasResponse({this.success, this.message, this.rightFormation, this.totalData, this.data});

  factory GrafikDewanKelasResponse.fromJson(Map<String, dynamic> json) =>
      _$GrafikDewanKelasResponseFromJson(json);

  static get serializer => _$GrafikDewanKelasResponseFromJson;
}