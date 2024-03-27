import 'package:bumn_eid/core/api/response/response_object.dart';
import 'package:json_annotation/json_annotation.dart';

part 'grafik_dewan_komisaris_grouped.g.dart';

@JsonSerializable(createToJson: false)
class GrafikDewanKomisarisGrouped extends ResponseObject {

  @JsonKey(name: 'upper')
  final String namaGroup;

  @JsonKey(name: 'jumlah')
  final int jumlah;

  GrafikDewanKomisarisGrouped({this.namaGroup, this.jumlah});

  factory GrafikDewanKomisarisGrouped.fromJson(Map<String, dynamic> json) =>
      _$GrafikDewanKomisarisGroupedFromJson(json);

  static get serializer => _$GrafikDewanKomisarisGroupedFromJson;

}