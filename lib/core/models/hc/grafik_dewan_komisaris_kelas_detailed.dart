import 'package:bumn_eid/core/api/response/response_object.dart';
import 'package:bumn_eid/ui/utils/widget_utils.dart';
import 'package:json_annotation/json_annotation.dart';

part 'grafik_dewan_komisaris_kelas_detailed.g.dart';

@JsonSerializable(createToJson: false)
class GrafikDewanKomisarisKelasDetailed extends ResponseObject with Searchable{

  @JsonKey(name: 'nama_pendek')
  final String namaPendek;

  @JsonKey(name: 'kelas_bumn')
  final String kelasBumn;

  @JsonKey(name: 'group_asal')
  final String groupAsal;

  @JsonKey(name: 'jumlah')
  final int jumlah;

  GrafikDewanKomisarisKelasDetailed({this.namaPendek, this.kelasBumn, this.groupAsal, this.jumlah});

  factory GrafikDewanKomisarisKelasDetailed.fromJson(Map<String, dynamic> json) =>
      _$GrafikDewanKomisarisKelasDetailedFromJson(json);

  static get serializer => _$GrafikDewanKomisarisKelasDetailedFromJson;

  @override
  String getKey() {
    return groupAsal;
  }

}