import 'package:bumn_eid/core/api/response/response_object.dart';
import 'package:json_annotation/json_annotation.dart';

part 'agama.g.dart';

@JsonSerializable()
class Agama extends ResponseObject {
  @JsonKey(name: 'agama')
  final String agama;

  @JsonKey(name: 'total')
  final int total;

  Agama({
    this.agama,
    this.total,
  });

  factory Agama.fromJson(Map<String, dynamic> json) => _$AgamaFromJson(json);

  static get serializer => _$AgamaFromJson;
}
