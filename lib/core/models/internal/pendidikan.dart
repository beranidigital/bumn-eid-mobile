import 'package:bumn_eid/core/api/response/response_object.dart';
import 'package:json_annotation/json_annotation.dart';

part 'pendidikan.g.dart';

@JsonSerializable()
class Pendidikan extends ResponseObject {
  @JsonKey(name: 'pendidikan')
  final String pendidikan;

  @JsonKey(name: 'total')
  final int total;

  Pendidikan({
    this.pendidikan,
    this.total,
  });

  factory Pendidikan.fromJson(Map<String, dynamic> json) =>
      _$PendidikanFromJson(json);

  static get serializer => _$PendidikanFromJson;
}
