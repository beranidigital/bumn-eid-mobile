import 'package:bumn_eid/core/api/response/response_object.dart';
import 'package:json_annotation/json_annotation.dart';

part 'bod_talent.g.dart';

@JsonSerializable(createToJson: false)
class BODTalent extends ResponseObject {

  @JsonKey(name: 'id')
  final int id;

  @JsonKey(name: 'id_angka')
  final String companyId;

  @JsonKey(name: 'nama_lengkap')
  final String companyName;

  @JsonKey(name: 'nama_pendek')
  final String companyShortName;

  @JsonKey(name: 'nama')
  final String name;

  @JsonKey(name: 'pangkat')
  final String pangkat;

  @JsonKey(name: 'bidang')
  final String bidang;

  @JsonKey(name: 'cluster_bumn')
  final String clusterBumn;

  @JsonKey(name: 'wamen_bumn')
  final String wamenBumn;

  @JsonKey(name: 'kelas_bumn')
  final String kelasBumn;

  @JsonKey(name: 'group_asal')
  final String group;

  @JsonKey(name: 'top_bumn')
  final String topBumn;

  @JsonKey(name: 'fungsi_direksi')
  final int fungsiDireksi;

  BODTalent({this.id, this.companyId, this.companyName, this.kelasBumn, this.name, this.group,
        this.wamenBumn, this.clusterBumn, this.bidang, this.companyShortName, this.fungsiDireksi, this.pangkat, this.topBumn});

  factory BODTalent.fromJson(Map<String, dynamic> json) =>
      _$BODTalentFromJson(json);

  static get serializer => _$BODTalentFromJson;

}