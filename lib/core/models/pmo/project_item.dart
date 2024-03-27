import 'package:bumn_eid/core/api/response/response_object.dart';
import 'package:json_annotation/json_annotation.dart';

part 'project_item.g.dart';

@JsonSerializable()
class ProjectItem extends ResponseObject {
  @JsonKey(name: 'id')
  final int id;

  @JsonKey(name: 'kode_projek')
  final int kode;

  @JsonKey(name: 'nama_projek')
  final String nama;

  @JsonKey(name: 'pic')
  final String pic;

  @JsonKey(name: 'progress')
  final String progress;

  @JsonKey(name: 'keterangan')
  final String keterangan;

  @JsonKey(name: 'id_bulan')
  final int bulan;

  @JsonKey(name: 'bulan')
  final String bulanString;

  @JsonKey(name: 'tahun')
  final int tahun;

  ProjectItem(
      {this.id,
      this.kode,
      this.nama,
      this.pic,
      this.progress,
      this.keterangan,
      this.tahun,
      this.bulan,
      this.bulanString});

  factory ProjectItem.fromJson(Map<String, dynamic> json) =>
      _$ProjectItemFromJson(json);

  static get serializer => _$ProjectItemFromJson;
}
