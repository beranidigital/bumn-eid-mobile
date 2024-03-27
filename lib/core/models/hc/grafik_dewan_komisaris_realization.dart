import 'package:bumn_eid/core/api/response/response_object.dart';
import 'package:json_annotation/json_annotation.dart';

part 'grafik_dewan_komisaris_realization.g.dart';

@JsonSerializable(createToJson: false)
class GrafikDewanKomisarisRealization extends ResponseObject {

  @JsonKey(name: 'group_asal')
  final String kategori;

  @JsonKey(name: 'jumlah')
  final int jumlah;

  GrafikDewanKomisarisRealization({this.kategori, this.jumlah});

  factory GrafikDewanKomisarisRealization.fromJson(Map<String, dynamic> json) =>
      _$GrafikDewanKomisarisRealizationFromJson(json);

  static get serializer => _$GrafikDewanKomisarisRealizationFromJson;

}