import 'package:bumn_eid/core/api/response/response_object.dart';
import 'package:bumn_eid/ui/components/custom_list_bar_chart.dart';
import 'package:bumn_eid/ui/utils/widget_utils.dart';
import 'package:json_annotation/json_annotation.dart';

part 'grafik_apbn.g.dart';

@JsonSerializable(createToJson: false)
class GrafikAPBN extends ResponseObject with ListBarChartDataType{

  @JsonKey(name: 'jumlah')
  final String jumlah;

  @JsonKey(name: 'tahun')
  final String tahun;

  @JsonKey(name: 'jenis_akun')
  final String jenis_akun;

  GrafikAPBN({this.jumlah, this.tahun, this.jenis_akun});

  factory GrafikAPBN.fromJson(Map<String, dynamic> json) =>
      _$GrafikAPBNFromJson(json);

  static get serializer => _$GrafikAPBNFromJson;

  @override
  String getColorKey() {
    return jenis_akun;
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