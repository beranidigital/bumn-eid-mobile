import 'package:bumn_eid/core/api/response/response_object.dart';
import 'package:bumn_eid/core/models/common/sortable.dart';
import 'package:bumn_eid/ui/utils/widget_utils.dart';
import 'package:json_annotation/json_annotation.dart';

part 'bl_item_area.g.dart';

@JsonSerializable(createToJson: false)
class BlItemArea extends ResponseObject with Sortable {

  @JsonKey(name: 'jenis_bantuan')
  final String jenisBantuan;

  @JsonKey(name: 'tahun')
  final int tahun;

  @JsonKey(name: 'realisasi')
  final String realisasi;

  BlItemArea({
     this.tahun, this.realisasi, this.jenisBantuan
  });

  factory BlItemArea.fromJson(Map<String, dynamic> json) =>
      _$BlItemAreaFromJson(json);

  static get serializer => _$BlItemAreaFromJson;

  double totalDana() {
    return parseDouble(realisasi);
  }

  num getNumber() {
    return totalDana();
  }

  int getTahun() {
    return tahun;
  }

  num getTotal() {
    return totalDana();
  }

}