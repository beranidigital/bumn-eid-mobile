import 'package:bumn_eid/core/api/response/response_object.dart';
import 'package:json_annotation/json_annotation.dart';

part 'bod1_talent_kesehatan.g.dart';

@JsonSerializable(createToJson: false)
class BOD1TalentKesehatan extends ResponseObject {

  @JsonKey(name: 'NILAI_KESEHATAN')
  final String nilai;

  @JsonKey(name: 'TAHUN_KESEHATAN')
  final String tahun;

  @JsonKey(name: 'INSTANSI_KESEHATAN')
  final String instansi;

  BOD1TalentKesehatan({
    this.nilai,
    this.tahun,
    this.instansi,
  });

  factory BOD1TalentKesehatan.fromJson(Map<String, dynamic> json) =>
      _$BOD1TalentKesehatanFromJson(json);

  static get serializer => _$BOD1TalentKesehatanFromJson;

}