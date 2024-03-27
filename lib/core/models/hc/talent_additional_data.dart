import 'package:bumn_eid/core/api/response/response_object.dart';
import 'package:json_annotation/json_annotation.dart';

part 'talent_additional_data.g.dart';

@JsonSerializable(createToJson: false)
class TalentAdditionalData extends ResponseObject {

  @JsonKey(name: 'nama')
  final String nama;

  @JsonKey(name: 'nik')
  final String nik;

  @JsonKey(name: 'kelas_bumn')
  final String kelas;

  @JsonKey(name: 'mobility')
  final String mobility;

  @JsonKey(name: 'feedback')
  final String feedback;

  @JsonKey(name: 'status')
  final String status;

  TalentAdditionalData({this.nama, this.kelas, this.status, this.mobility, this.feedback, this.nik});

  factory TalentAdditionalData.fromJson(Map<String, dynamic> json) =>
      _$TalentAdditionalDataFromJson(json);

  static get serializer => _$TalentAdditionalDataFromJson;

}