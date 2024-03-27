import 'package:bumn_eid/core/api/response/response_object.dart';
import 'package:bumn_eid/core/models/common/sortable.dart';
import 'package:bumn_eid/ui/components/bigger_custom_table.dart';
import 'package:bumn_eid/ui/utils/widget_utils.dart';
import 'package:json_annotation/json_annotation.dart';

part 'summary.g.dart';

@JsonSerializable(createToJson: false)
class Summary extends ResponseObject with Sortable, BiggerCustomTableData {

  @JsonKey(name: 'nama_summary')
  final String nama;

  @JsonKey(name: 'tahun')
  final int tahun;

  @JsonKey(name: 'jumlah')
  final String jumlah;

  @JsonKey(name: 'jenis_akun')
  final String jenisAkun;

  @JsonKey(name: 'kode_kategori')
  final int kodeKategori;

  @JsonKey(name: 'kode_summary')
  final int kodeSummary;

  Summary({this.nama, this.tahun, this.jumlah, this.jenisAkun, this.kodeKategori, this.kodeSummary});

  factory Summary.fromJson(Map<String, dynamic> json) =>
      _$SummaryFromJson(json);

  static get serializer => _$SummaryFromJson;

  @override
  num getNumber() {
    return parseDouble(jumlah);
  }

  @override
  num getJumlah() {
    return parseDouble(jumlah);
  }

  @override
  String getTahun() {
    return tahun.toString();
  }



}