import 'package:bumn_eid/core/api/response/response_object.dart';
import 'package:json_annotation/json_annotation.dart';

part 'unit_kerja.g.dart';

@JsonSerializable()
class UnitKerja extends ResponseObject {
  @JsonKey(name: 'unit_kerja')
  final String unitKerja;

  @JsonKey(name: 'total')
  final int total;

  UnitKerja({
    this.unitKerja,
    this.total,
  });

  factory UnitKerja.fromJson(Map<String, dynamic> json) =>
      _$UnitKerjaFromJson(json);

  static get serializer => _$UnitKerjaFromJson;
}
