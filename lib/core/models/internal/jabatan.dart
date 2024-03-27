import 'package:bumn_eid/core/api/response/response_object.dart';
import 'package:json_annotation/json_annotation.dart';

part 'jabatan.g.dart';

@JsonSerializable()
class Jabatan extends ResponseObject {
  @JsonKey(name: 'jabatan')
  final String jabatan;

  @JsonKey(name: 'total')
  final int total;

  Jabatan({
    this.jabatan,
    this.total,
  });

  factory Jabatan.fromJson(Map<String, dynamic> json) =>
      _$JabatanFromJson(json);

  static get serializer => _$JabatanFromJson;
}
