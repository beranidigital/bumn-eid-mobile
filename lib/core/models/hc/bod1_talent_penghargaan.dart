import 'package:bumn_eid/core/api/response/response_object.dart';
import 'package:json_annotation/json_annotation.dart';

part 'bod1_talent_penghargaan.g.dart';

@JsonSerializable(createToJson: false)
class BOD1TalentPenghargaan extends ResponseObject {

  @JsonKey(name: 'JENIS_PENGHARGAAN')
  final String jenisPenghargaan;

  @JsonKey(name: 'TINGKAT')
  final String tingkat;

  @JsonKey(name: 'DIBERIKAN')
  final String diberikan;

  @JsonKey(name: 'TAHUN')
  final String tahun;

  BOD1TalentPenghargaan({
    this.jenisPenghargaan,
    this.tingkat,
    this.diberikan,
    this.tahun
  });

  factory BOD1TalentPenghargaan.fromJson(Map<String, dynamic> json) =>
      _$BOD1TalentPenghargaanFromJson(json);

  static get serializer => _$BOD1TalentPenghargaanFromJson;

}