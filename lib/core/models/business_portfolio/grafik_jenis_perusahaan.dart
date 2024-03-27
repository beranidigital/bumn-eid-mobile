import 'package:bumn_eid/core/api/response/response_object.dart';
import 'package:bumn_eid/ui/components/custom_list_bar_chart.dart';
import 'package:json_annotation/json_annotation.dart';

part 'grafik_jenis_perusahaan.g.dart';

@JsonSerializable(createToJson: false)
class GrafikJenisPerusahaan extends ResponseObject with ListBarChartDataType {

  @JsonKey(name: 'jumlah')
  final int jumlah;

  @JsonKey(name: 'tahun')
  final String tahun;

  @JsonKey(name: 'jenis_bumn')
  final String jenis_bumn;

  GrafikJenisPerusahaan({this.jumlah, this.tahun, this.jenis_bumn});

  factory GrafikJenisPerusahaan.fromJson(Map<String, dynamic> json) =>
      _$GrafikJenisPerusahaanFromJson(json);

  static get serializer => _$GrafikJenisPerusahaanFromJson;

  @override
  String getColorKey() {
    return tahun;
  }

  @override
  int getX() {
    return jenis_bumn.hashCode;
  }

  @override
  double getY() {
    return jumlah.toDouble();
  }

}


String jenisBumnToCode(String enumJenis) {
  switch (enumJenis) {
    case "Persero":
      return "1";
    case "Perum":
      return "2";
    case "Persero Tbk":
      return "3";
    case "Minoritas":
      return "4";
    default: return "1";
  }
}