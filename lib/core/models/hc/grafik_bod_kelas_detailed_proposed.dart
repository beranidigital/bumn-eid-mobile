import 'package:bumn_eid/core/api/response/response_object.dart';
import 'package:bumn_eid/ui/utils/widget_utils.dart';
import 'package:json_annotation/json_annotation.dart';

part 'grafik_bod_kelas_detailed_proposed.g.dart';

@JsonSerializable(createToJson: false)
class GrafikBODKelasDetailedProposed extends ResponseObject with Searchable{

  @JsonKey(name: 'nama')
  final String nama;

  @JsonKey(name: 'kategori')
  final String kategori;

  @JsonKey(name: 'satuan')
  final String satuan;

  @JsonKey(name: 'jumlah_min')
  final int jumlahMin;

  @JsonKey(name: 'jumlah_max')
  final int jumlahMax;

  @JsonKey(name: 'keterangan')
  final String keterangan;

  GrafikBODKelasDetailedProposed({this.nama, this.kategori, this.satuan, this.jumlahMin, this.jumlahMax, this.keterangan});

  factory GrafikBODKelasDetailedProposed.fromJson(Map<String, dynamic> json) =>
      _$GrafikBODKelasDetailedProposedFromJson(json);

  static get serializer => _$GrafikBODKelasDetailedProposedFromJson;

  @override
  String getKey() {
    return nama;
  }

}