import 'package:bumn_eid/core/api/response/response_object.dart';
import 'package:json_annotation/json_annotation.dart';

part 'anak_perusahaan.g.dart';

@JsonSerializable()
class AnakPerusahaan extends ResponseObject {

  @JsonKey(name: 'id_angka')
  final String id;

  @JsonKey(name: 'induk')
  final String induk;

  @JsonKey(name: 'anak')
  final String anak;

  @JsonKey(name: 'persentase')
  final String persentase;

  AnakPerusahaan({
    this.id,
    this.induk,
    this.anak,
    this.persentase,
  });

  factory AnakPerusahaan.fromJson(Map<String, dynamic> json) =>
      _$AnakPerusahaanFromJson(json);

  static get serializer => _$AnakPerusahaanFromJson;

  Map toJson() {
    return _$AnakPerusahaanToJson(this);
  }

}