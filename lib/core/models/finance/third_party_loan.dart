import 'package:bumn_eid/core/api/response/response_object.dart';
import 'package:bumn_eid/core/models/common/sortable.dart';
import 'package:bumn_eid/ui/utils/widget_utils.dart';
import 'package:json_annotation/json_annotation.dart';

part 'third_party_loan.g.dart';

@JsonSerializable(createToJson: false)
class ThirdPartyLoan extends ResponseObject with Sortable {

  @JsonKey(name: 'id')
  final int id;

  @JsonKey(name: 'id_angka')
  final String companyId;

  @JsonKey(name: 'nama_lengkap')
  final String namaPerusahaan;

  @JsonKey(name: 'tahun')
  final int tahun;
  
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

  ThirdPartyLoan({this.companyId, this.namaPerusahaan, this.tahun, this.jumlah, this.kelas, this.cluster, this.id, this.wamen, this.satuan});

  factory ThirdPartyLoan.fromJson(Map<String, dynamic> json) =>
      _$ThirdPartyLoanFromJson(json);

  static get serializer => _$ThirdPartyLoanFromJson;

  @override
  num getNumber() {
    return parseDouble(jumlah).toInt();
  }

}