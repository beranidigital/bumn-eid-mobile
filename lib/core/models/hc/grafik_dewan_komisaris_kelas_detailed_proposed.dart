import 'package:bumn_eid/core/api/response/response_object.dart';
import 'package:bumn_eid/ui/utils/widget_utils.dart';
import 'package:json_annotation/json_annotation.dart';

part 'grafik_dewan_komisaris_kelas_detailed_proposed.g.dart';

@JsonSerializable(createToJson: false)
class GrafikDewanKomisarisKelasDetailedProposed extends ResponseObject with Searchable{

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

  GrafikDewanKomisarisKelasDetailedProposed({this.nama, this.kategori, this.satuan, this.jumlahMin, this.jumlahMax, this.keterangan});

  factory GrafikDewanKomisarisKelasDetailedProposed.fromJson(Map<String, dynamic> json) =>
      _$GrafikDewanKomisarisKelasDetailedProposedFromJson(json);

  static get serializer => _$GrafikDewanKomisarisKelasDetailedProposedFromJson;

  @override
  String getKey() {
    return nama;
  }

}