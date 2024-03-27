import 'package:bumn_eid/core/api/response/response_object.dart';
import 'package:bumn_eid/ui/utils/widget_utils.dart';
import 'package:json_annotation/json_annotation.dart';

part 'sektor_pk.g.dart';

@JsonSerializable()
class SektorPk extends ResponseObject {

  @JsonKey(name: 'sektor_usaha')
  final String sektor;

  @JsonKey(name: 'tahun')
  final int tahun;

  @JsonKey(name: 'jumlah')
  final String jumlah;

  SektorPk({
    this.sektor, this.tahun, this.jumlah
  });

  factory SektorPk.fromJson(Map<String, dynamic> json) =>
      _$SektorPkFromJson(json);

  static get serializer => _$SektorPkFromJson;

  num getJumlah() {
    return parseDouble(jumlah);
  }

}

// Extension functions on NavigatorState
extension MapListExtension on Map<String, List<SektorPk>> {
  Map<String, List<SektorPk>> sortBasedOnValue({bool absValue = true}) {
    Map<String, List<SektorPk>> output = {};
    List<String> sortedKeys = this.keys.toList()..sort((a,b) {
      try {
        num bNum = this[b].fold(0, (x,y) => x+y.getJumlah());
        if (absValue) bNum = bNum.abs();
        num aNum = this[a].fold(0, (x,y) => x+y.getJumlah());
        if (absValue) aNum = aNum.abs();
        return bNum.compareTo(aNum);
      } catch (ex) {
        return 0;
      }
    });
    sortedKeys.forEach((key) => output[key] = this[key]);
    return output;
  }
}