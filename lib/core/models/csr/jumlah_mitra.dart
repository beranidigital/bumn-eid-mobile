import 'package:bumn_eid/core/api/response/response_object.dart';
import 'package:json_annotation/json_annotation.dart';

part 'jumlah_mitra.g.dart';

@JsonSerializable()
class JumlahMitra extends ResponseObject {

  @JsonKey(name: 'sektor_usaha')
  final String sektorUsaha;

  @JsonKey(name: 'tahun')
  final int tahun;

  @JsonKey(name: 'total_mitra')
  final int totalMitra;

  @JsonKey(name: 'jumlah')
  final String jumlah;

  JumlahMitra({this.sektorUsaha, this.tahun, this.totalMitra, this.jumlah});

  factory JumlahMitra.fromJson(Map<String, dynamic> json) =>
      _$JumlahMitraFromJson(json);

  static get serializer => _$JumlahMitraFromJson;

}