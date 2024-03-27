import 'package:bumn_eid/core/api/response/response_object.dart';
import 'package:json_annotation/json_annotation.dart';

part 'grafik_laba_rugi.g.dart';

@JsonSerializable(createToJson: false)
class GrafikLabaRugi extends ResponseObject {
  @JsonKey(name: 'laba')
  final String laba;

  @JsonKey(name: 'rugi')
  final String rugi;

  @JsonKey(name: 'lababersih')
  final String labaBersih;

  String jumlah;

  @JsonKey(name: 'tahun')
  final String tahun;

  GrafikLabaRugi({
    this.laba,
    this.rugi,
    this.labaBersih,
    this.tahun,
    this.jumlah,
  });

  factory GrafikLabaRugi.fromJson(Map<String, dynamic> json) =>
      _$GrafikLabaRugiFromJson(json);

  static get serializer => _$GrafikLabaRugiFromJson;
}

String akunLabaRugiToCode(String enumJenis) {
  print("enum is $enumJenis");
  switch (enumJenis.toLowerCase()) {
    case "laba":
      return "1";
    case "rugi":
      return "2";
    default:
      return "1";
  }
}
