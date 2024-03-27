import 'package:bumn_eid/core/api/response/response_object.dart';
import 'package:bumn_eid/core/models/common/sortable.dart';
import 'package:bumn_eid/ui/utils/widget_utils.dart';
import 'package:json_annotation/json_annotation.dart';

part 'pk_item_area.g.dart';

@JsonSerializable(createToJson: false)
class PkItemArea extends ResponseObject with Sortable {

  @JsonKey(name: 'propinsi')
  final String propinsi;

  @JsonKey(name: 'sektor_usaha')
  final String sektorUsaha;

  @JsonKey(name: 'tahun')
  final int tahun;

  @JsonKey(name: 'lancar')
  final String lancar;

  @JsonKey(name: 'kurang_lancar')
  final String kurangLancar;

  @JsonKey(name: 'diragukan')
  final String diragukan;

  @JsonKey(name: 'macet')
  final String macet;

  @JsonKey(name: 'total_mitra')
  final int totalMitra;

  @JsonKey(name: 'total_realisasi')
  final String totalRealisasi;

  PkItemArea({
     this.tahun, this.propinsi, this.totalMitra, this.sektorUsaha, this.lancar, this.macet, this.diragukan,
     this.kurangLancar, this.totalRealisasi
  });

  factory PkItemArea.fromJson(Map<String, dynamic> json) =>
      _$PkItemAreaFromJson(json);

  static get serializer => _$PkItemAreaFromJson;

  double totalDana() {
    return parseDouble(totalRealisasi);
  }

  num getNumber() {
    return totalDana();
  }

  String getPropinsi() {
    return propinsi;
  }

  int getTahun() {
    return tahun;
  }

  num getTotal() {
    return totalDana();
  }

}