import 'package:bumn_eid/core/api/response/response_object.dart';
import 'package:json_annotation/json_annotation.dart';

part 'grafik_dewan_komisaris_kelas.g.dart';

@JsonSerializable(createToJson: false)
class GrafikDewanKomisarisKelas extends ResponseObject {

  @JsonKey(name: 'kelas_bumn')
  final String kelas;

  @JsonKey(name: 'jumlah')
  final int jumlah;

  GrafikDewanKomisarisKelas({this.kelas, this.jumlah});

  factory GrafikDewanKomisarisKelas.fromJson(Map<String, dynamic> json) =>
      _$GrafikDewanKomisarisKelasFromJson(json);

  static get serializer => _$GrafikDewanKomisarisKelasFromJson;

}