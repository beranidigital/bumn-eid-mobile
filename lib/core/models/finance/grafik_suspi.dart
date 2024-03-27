import 'package:bumn_eid/core/api/response/response_object.dart';
import 'package:bumn_eid/core/models/common/sortable.dart';
import 'package:bumn_eid/core/utils/constants.dart';
import 'package:bumn_eid/ui/components/custom_list_bar_chart.dart';
import 'package:bumn_eid/ui/utils/widget_utils.dart';
import 'package:json_annotation/json_annotation.dart';

part 'grafik_suspi.g.dart';

@JsonSerializable(createToJson: false)
class GrafikSuspi extends ResponseObject with ListBarChartDataType, Sortable{

  @JsonKey(name: 'tahun')
  final int tahun;

  @JsonKey(name: 'jumlah')
  final String jumlah;

  @JsonKey(name: 'jenis_akun')
  final String jenisAkun;

  @JsonKey(name: 'kode_kategori')
  final int kodeKategori;

  GrafikSuspi({this.tahun, this.jumlah, this.kodeKategori, this.jenisAkun});

  factory GrafikSuspi.fromJson(Map<String, dynamic> json) =>
      _$GrafikSuspiFromJson(json);

  static get serializer => _$GrafikSuspiFromJson;

  @override
  String getColorKey() {
    return jenisAkun;
  }

  @override
  int getX() {
    return tahun;
  }

  @override
  double getY() {
    return getJumlah();
  }

  double getJumlah() {
    return parseDouble(jumlah) / Constants.million;
  }

  @override
  num getNumber() {
    return getJumlah();
  }

}