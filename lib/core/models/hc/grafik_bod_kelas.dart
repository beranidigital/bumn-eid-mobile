import 'package:bumn_eid/core/api/response/response_object.dart';
import 'package:json_annotation/json_annotation.dart';

part 'grafik_bod_kelas.g.dart';

@JsonSerializable(createToJson: false)
class GrafikBODKelas extends ResponseObject {

  @JsonKey(name: 'kelas_bumn')
  final String kelas;

  @JsonKey(name: 'jumlah')
  final int jumlah;

  GrafikBODKelas({this.kelas, this.jumlah});

  factory GrafikBODKelas.fromJson(Map<String, dynamic> json) =>
      _$GrafikBODKelasFromJson(json);

  static get serializer => _$GrafikBODKelasFromJson;

}