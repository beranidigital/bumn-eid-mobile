import 'package:bumn_eid/core/api/response/response_object.dart';
import 'package:bumn_eid/ui/utils/widget_utils.dart';
import 'package:json_annotation/json_annotation.dart';

part 'grafik_bod_kelas_detailed.g.dart';

@JsonSerializable(createToJson: false)
class GrafikBODKelasDetailed extends ResponseObject with Searchable{

  @JsonKey(name: 'nama_pendek')
  final String namaPendek;

  @JsonKey(name: 'kelas_bumn')
  final String kelasBumn;

  @JsonKey(name: 'group_asal')
  final String groupAsal;

  @JsonKey(name: 'jumlah')
  final int jumlah;

  GrafikBODKelasDetailed({this.namaPendek, this.kelasBumn, this.groupAsal, this.jumlah});

  factory GrafikBODKelasDetailed.fromJson(Map<String, dynamic> json) =>
      _$GrafikBODKelasDetailedFromJson(json);

  static get serializer => _$GrafikBODKelasDetailedFromJson;

  @override
  String getKey() {
    return groupAsal;
  }

}