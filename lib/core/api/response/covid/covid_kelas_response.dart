import 'package:bumn_eid/core/api/response/response_object.dart';
import 'package:bumn_eid/core/models/covid/covid_kelas.dart';
import 'package:json_annotation/json_annotation.dart';

part 'covid_kelas_response.g.dart';

@JsonSerializable(createToJson: false)
class CovidKelasResponse extends ResponseObject {
  @JsonKey(name: 'success')
  final bool success;

  @JsonKey(name: 'message')
  final String message;

  @JsonKey(name: 'data')
  final List<CovidKelas> data;


  CovidKelasResponse({this.success, this.message, this.data});

  factory CovidKelasResponse.fromJson(Map<String, dynamic> json) =>
      _$CovidKelasResponseFromJson(json);

  static get serializer => _$CovidKelasResponseFromJson;
}