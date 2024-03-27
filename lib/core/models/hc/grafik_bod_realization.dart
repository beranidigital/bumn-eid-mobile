import 'package:bumn_eid/core/api/response/response_object.dart';
import 'package:json_annotation/json_annotation.dart';

part 'grafik_bod_realization.g.dart';

@JsonSerializable(createToJson: false)
class GrafikBODRealization extends ResponseObject {

  @JsonKey(name: 'klasifikasi_asal_instansi_direksi')
  final String kategori;

  @JsonKey(name: 'jumlah')
  final int jumlah;

  GrafikBODRealization({this.kategori, this.jumlah});

  factory GrafikBODRealization.fromJson(Map<String, dynamic> json) =>
      _$GrafikBODRealizationFromJson(json);

  static get serializer => _$GrafikBODRealizationFromJson;

}