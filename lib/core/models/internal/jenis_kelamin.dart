import 'package:bumn_eid/core/api/response/response_object.dart';
import 'package:json_annotation/json_annotation.dart';

part 'jenis_kelamin.g.dart';

@JsonSerializable()
class JenisKelamin extends ResponseObject {
  @JsonKey(name: 'jenis_kelamin')
  final String jenisKelamin;

  @JsonKey(name: 'total')
  final int total;

  JenisKelamin({
    this.jenisKelamin,
    this.total,
  });

  factory JenisKelamin.fromJson(Map<String, dynamic> json) =>
      _$JenisKelaminFromJson(json);

  static get serializer => _$JenisKelaminFromJson;
}
