import 'package:bumn_eid/core/api/response/response_object.dart';
import 'package:bumn_eid/ui/components/single_list_view.dart';
import 'package:json_annotation/json_annotation.dart';

part 'jenis_perusahaan.g.dart';

@JsonSerializable(createToJson: false)
class JenisPerusahaan extends ResponseObject with SingleListItem {

  @JsonKey(name: 'id_angka')
  final String id;

  @JsonKey(name: 'nama_perusahaan')
  final String nama;

  @JsonKey(name: 'tahun')
  final String tahun;

  @JsonKey(name: 'jenis_bumn')
  final String jenis_bumn;

  JenisPerusahaan({this.id, this.nama, this.tahun, this.jenis_bumn});

  factory JenisPerusahaan.fromJson(Map<String, dynamic> json) =>
      _$JenisPerusahaanFromJson(json);

  static get serializer => _$JenisPerusahaanFromJson;

  @override
  String getTitle() {
    return nama;
  }

}