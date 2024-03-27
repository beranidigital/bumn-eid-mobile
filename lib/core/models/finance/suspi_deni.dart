import 'package:bumn_eid/core/api/response/response_object.dart';
import 'package:bumn_eid/core/models/common/sortable.dart';
import 'package:bumn_eid/core/utils/constants.dart';
import 'package:bumn_eid/ui/utils/widget_utils.dart';
import 'package:json_annotation/json_annotation.dart';

part 'suspi_deni.g.dart';

@JsonSerializable(createToJson: false)
class SuspiDeni extends ResponseObject with Sortable {

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

  @JsonKey(name: 'jenis_akun')
  final String jenisAkun;

  @JsonKey(name: 'kode_kategori')
  final int kodeKategori;

  SuspiDeni({this.companyId, this.namaPerusahaan, this.tahun, this.jenisAkun,
    this.id, this.kodeKategori, this.satuan,
    this.jumlah});

  factory SuspiDeni.fromJson(Map<String, dynamic> json) =>
      _$SuspiDeniFromJson(json);

  static get serializer => _$SuspiDeniFromJson;

  @override
  num getNumber() {
    return parseDouble(jumlah)/Constants.million;
  }

}