import 'dart:ui';

import 'package:bumn_eid/core/api/response/response_object.dart';
import 'package:bumn_eid/ui/components/custom_bar_chart.dart';
import 'package:json_annotation/json_annotation.dart';

part 'grafik_capex.g.dart';

@JsonSerializable(createToJson: false)
class GrafikCapex extends ResponseObject with BarChartDataType {

  @JsonKey(name: 'jumlah')
  final int jumlah;

  @JsonKey(name: 'tahun')
  final int tahun;

  @JsonKey(name: 'jenis_akun')
  final String jenisAkun;

  @JsonKey(name: 'satuan')
  final String satuan;

  GrafikCapex({this.jumlah, this.tahun, this.jenisAkun, this.satuan});

  factory GrafikCapex.fromJson(Map<String, dynamic> json) =>
      _$GrafikCapexFromJson(json);

  static get serializer => _$GrafikCapexFromJson;

  @override
  Color getColor() {
    return Color(0xFFFBD300);
  }

  @override
  int getX() {
    return tahun;
  }

  @override
  double getY() {
    return jumlah.toDouble();
  }

}