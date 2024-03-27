import 'package:bumn_eid/core/api/response/response_object.dart';
import 'package:json_annotation/json_annotation.dart';

part 'pref_jabatan.g.dart';

@JsonSerializable()
class PrefJabatan extends ResponseObject {
  @JsonKey(name: 'pref_jabatan')
  final String prefJabatan;

  @JsonKey(name: 'total')
  final int total;

  PrefJabatan({
    this.prefJabatan,
    this.total,
  });

  factory PrefJabatan.fromJson(Map<String, dynamic> json) =>
      _$PrefJabatanFromJson(json);

  static get serializer => _$PrefJabatanFromJson;
}
