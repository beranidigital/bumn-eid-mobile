import 'package:bumn_eid/core/api/response/response_object.dart';
import 'package:bumn_eid/core/models/hc/grafik_dewan_komisaris_cluster.dart';
import 'package:bumn_eid/core/models/hc/grafik_dewan_komisaris_grouped.dart';
import 'package:bumn_eid/core/models/hc/grafik_dewan_komisaris_kelas.dart';
import 'package:bumn_eid/core/models/hc/grafik_potret_kerja.dart';
import 'package:json_annotation/json_annotation.dart';

part 'grafik_potret_tugas_response.g.dart';

@JsonSerializable(createToJson: false)
class GrafikPotretTugasResponse extends ResponseObject {
  @JsonKey(name: 'success')
  final bool success;

  @JsonKey(name: 'message')
  final String message;

  @JsonKey(name: 'data')
  final List<GrafikPotretTugas> data;

  GrafikPotretTugasResponse({this.success, this.message, this.data});

  factory GrafikPotretTugasResponse.fromJson(Map<String, dynamic> json) =>
      _$GrafikPotretTugasResponseFromJson(json);

  static get serializer => _$GrafikPotretTugasResponseFromJson;
}