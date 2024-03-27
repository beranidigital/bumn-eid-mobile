import 'package:bumn_eid/core/api/response/response_object.dart';
import 'package:bumn_eid/core/models/common/sortable.dart';
import 'package:bumn_eid/ui/utils/widget_utils.dart';
import 'package:json_annotation/json_annotation.dart';

part 'loan.g.dart';

@JsonSerializable(createToJson: false)
class Loan extends ResponseObject with Sortable {

  @JsonKey(name: 'id')
  final int id;

  @JsonKey(name: 'id_angka')
  final String companyId;

  @JsonKey(name: 'nama_lengkap')
  final String namaPerusahaan;

  @JsonKey(name: 'tahun')
  final int tahun;
  
  @JsonKey(name: 'obligasi')
  final String obligasi;

  @JsonKey(name: 'mtn')
  final String mtn;

  @JsonKey(name: 'ncd')
  final String ncd;

  @JsonKey(name: 'sukuk')
  final String sukuk;

  @JsonKey(name: 'efeklain')
  final String efekLain;

  @JsonKey(name: 'jumlah')
  final String jumlah;

  @JsonKey(name: 'satuan')
  final String satuan;

  @JsonKey(name: 'cluster_bumn')
  final String cluster;

  @JsonKey(name: 'wamen_bumn')
  final String wamen;

  @JsonKey(name: 'kelas_bumn')
  final String kelas;

  Loan({this.companyId, this.namaPerusahaan, this.tahun, this.efekLain, this.kelas, this.cluster,
    this.id, this.wamen, this.satuan,
    this.sukuk, this.obligasi, this.ncd, this.mtn, this.jumlah});

  factory Loan.fromJson(Map<String, dynamic> json) =>
      _$LoanFromJson(json);

  static get serializer => _$LoanFromJson;

  @override
  num getNumber() {
    return parseDouble(jumlah).toInt();
  }

}