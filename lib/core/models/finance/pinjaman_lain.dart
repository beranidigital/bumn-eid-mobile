import 'package:bumn_eid/core/api/response/response_object.dart';
import 'package:bumn_eid/core/models/common/sortable.dart';
import 'package:bumn_eid/ui/utils/widget_utils.dart';
import 'package:json_annotation/json_annotation.dart';

part 'pinjaman_lain.g.dart';

@JsonSerializable(createToJson: false)
class PinjamanLain extends ResponseObject with Sortable {

  @JsonKey(name: 'id_angka')
  final String companyId;

  @JsonKey(name: 'nama_lengkap')
  final String namaPerusahaan;

  @JsonKey(name: 'tahun')
  final int tahun;
  
  @JsonKey(name: 'utang_bank')
  final int utangBank;

  @JsonKey(name: 'utang_ri')
  final int utangRi;

  @JsonKey(name: 'pinj_subordinasi')
  final int pinjSubordinasi;

  @JsonKey(name: 'utang_sp')
  final int utangSp;

  @JsonKey(name: 'jumlah')
  final int jumlah;

  @JsonKey(name: 'satuan')
  final String satuan;

  @JsonKey(name: 'cluster_bumn')
  final String cluster;

  @JsonKey(name: 'wamen_bumn')
  final String wamen;

  @JsonKey(name: 'kelas_bumn')
  final String kelas;

  PinjamanLain({this.companyId, this.namaPerusahaan, this.tahun, this.utangBank, this.kelas, this.cluster,
    this.utangRi, this.wamen, this.satuan,
    this.utangSp, this.pinjSubordinasi, this.jumlah});

  factory PinjamanLain.fromJson(Map<String, dynamic> json) =>
      _$PinjamanLainFromJson(json);

  static get serializer => _$PinjamanLainFromJson;

  @override
  num getNumber() {
    return jumlah;
  }

}