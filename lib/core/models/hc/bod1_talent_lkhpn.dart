import 'package:bumn_eid/core/api/response/response_object.dart';
import 'package:json_annotation/json_annotation.dart';

part 'bod1_talent_lkhpn.g.dart';

@JsonSerializable(createToJson: false)
class BOD1TalentLkhpn extends ResponseObject {

  @JsonKey(name: 'TGL_PELAPORAN')
  final String tanggalPelaporan;

  @JsonKey(name: 'JML_KEKAYAAN_RP')
  final String jumlahKekayaanRp;

  @JsonKey(name: 'JML_KEKAYAAN_USD')
  final String jumlahKekayaanUsd;

  @JsonKey(name: 'PRE_URL')
  final String preUrl;

  BOD1TalentLkhpn({
    this.tanggalPelaporan,
    this.jumlahKekayaanRp,
    this.jumlahKekayaanUsd,
    this.preUrl
  });

  factory BOD1TalentLkhpn.fromJson(Map<String, dynamic> json) =>
      _$BOD1TalentLkhpnFromJson(json);

  static get serializer => _$BOD1TalentLkhpnFromJson;

}