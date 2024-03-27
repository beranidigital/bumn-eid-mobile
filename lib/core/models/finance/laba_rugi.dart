import 'package:bumn_eid/core/api/response/response_object.dart';
import 'package:bumn_eid/core/models/common/sortable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'laba_rugi.g.dart';

@JsonSerializable(createToJson: false)
class LabaRugi extends ResponseObject with Sortable {

  @JsonKey(name: 'id_angka')
  final String id;

  @JsonKey(name: 'nama_lengkap')
  final String namaPerusahaan;

  @JsonKey(name: 'tahun')
  final String tahun;

  @JsonKey(name: 'periode_nama')
  final String periodeNama;

  @JsonKey(name: 'jumlah')
  final String jumlah;

  @JsonKey(name: 'satuan')
  final String satuan;

  @JsonKey(name: 'jenis_akun')
  final String jenisAkun;

  @JsonKey(name: 'jenis_akun_id')
  final String jenisAkunId;

  LabaRugi({this.id, this.namaPerusahaan, this.tahun, this.jumlah, this.periodeNama, this.satuan, this.jenisAkun, this.jenisAkunId});

  factory LabaRugi.fromJson(Map<String, dynamic> json) =>
      _$LabaRugiFromJson(json);

  static get serializer => _$LabaRugiFromJson;

  @override
  num getNumber() {
    return int.parse(jumlah);
  }

}