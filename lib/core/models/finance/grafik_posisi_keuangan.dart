import 'package:bumn_eid/core/api/response/response_object.dart';
import 'package:bumn_eid/ui/components/custom_list_bar_chart.dart';
import 'package:bumn_eid/ui/utils/widget_utils.dart';
import 'package:json_annotation/json_annotation.dart';

part 'grafik_posisi_keuangan.g.dart';

@JsonSerializable(createToJson: false)
class GrafikPosisiKeuangan extends ResponseObject with ListBarChartDataType {

  @JsonKey(name: 'jumlah')
  final String jumlah;

  @JsonKey(name: 'tahun')
  final String tahun;

  @JsonKey(name: 'jenis_akun')
  final String jenisAkun;

  GrafikPosisiKeuangan({this.jumlah, this.tahun, this.jenisAkun});

  factory GrafikPosisiKeuangan.fromJson(Map<String, dynamic> json) =>
      _$GrafikPosisiKeuanganFromJson(json);

  static get serializer => _$GrafikPosisiKeuanganFromJson;

  @override
  String getColorKey() {
    return jenisAkun;
  }

  @override
  int getX() {
    return int.parse(tahun);
  }

  @override
  double getY() {
    return parseDouble(jumlah);
  }

}

String akunToCode(String enumJenis) {
  switch (enumJenis) {
    case "Aset":
      return "1";
    case "Liabilitas":
      return "2";
    case "Ekuitas":
      return "3";
    default: return "1";
  }
}