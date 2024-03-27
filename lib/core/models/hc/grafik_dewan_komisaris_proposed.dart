import 'package:bumn_eid/core/api/response/response_object.dart';
import 'package:json_annotation/json_annotation.dart';

part 'grafik_dewan_komisaris_proposed.g.dart';

@JsonSerializable(createToJson: false)
class GrafikDewanKomisarisProposed extends ResponseObject {

  @JsonKey(name: 'nama')
  final String nama;

  @JsonKey(name: 'kategori')
  final String kategori;

  @JsonKey(name: 'jumlah')
  final int jumlah;

  @JsonKey(name: 'satuan')
  final String satuan;

  GrafikDewanKomisarisProposed({this.nama, this.kategori, this.jumlah, this.satuan});

  factory GrafikDewanKomisarisProposed.fromJson(Map<String, dynamic> json) =>
      _$GrafikDewanKomisarisProposedFromJson(json);

  static get serializer => _$GrafikDewanKomisarisProposedFromJson;

}