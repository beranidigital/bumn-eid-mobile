import 'package:bumn_eid/core/api/response/response_object.dart';
import 'package:bumn_eid/core/models/common/sortable.dart';
import 'package:bumn_eid/ui/utils/widget_utils.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'pk_item_company.g.dart';

@JsonSerializable(createToJson: false)
class PkItemCompany extends ResponseObject with Sortable {

  @JsonKey(name: 'propinsi')
  final String propinsi;

  @JsonKey(name: 'tahun')
  final int tahun;

  @JsonKey(name: 'lat')
  final String lat;

  @JsonKey(name: 'lng')
  final String lng;

  @JsonKey(name: 'total_mitra')
  final int totalMitra;

  @JsonKey(name: 'realisasi')
  final String realisasi;

  PkItemCompany({
     this.tahun, this.propinsi, this.totalMitra, this.realisasi, this.lat, this.lng
  });

  factory PkItemCompany.fromJson(Map<String, dynamic> json) =>
      _$PkItemCompanyFromJson(json);

  static get serializer => _$PkItemCompanyFromJson;

  double totalDana() {
    return parseDouble(realisasi);
  }

  num getNumber() {
    return totalDana();
  }

  LatLng getLatLng() {
    return LatLng(
      parseDouble(lat),
      parseDouble(lng),
    );
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

// Extension functions on NavigatorState
extension MapListExtension on Map<String, PkItemCompany> {
  Map<String, PkItemCompany> sortBasedOnValue({bool absValue = true}) {
    Map<String, PkItemCompany> output = {};
    List<String> sortedKeys = this.keys.toList()..sort((a,b) {
      try {
        num bNum = this[b].totalDana();
        if (absValue) bNum = bNum.abs();
        num aNum = this[a].totalDana();
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