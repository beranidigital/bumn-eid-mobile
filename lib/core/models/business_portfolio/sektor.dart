import 'package:bumn_eid/core/api/response/response_object.dart';
import 'package:json_annotation/json_annotation.dart';

part 'sektor.g.dart';

@JsonSerializable()
class Sektor extends ResponseObject {

  @JsonKey(name: 'sektor_bps')
  final String sektor;

  Sektor({
    this.sektor,
  });

  factory Sektor.fromJson(Map<String, dynamic> json) =>
      _$SektorFromJson(json);

  static get serializer => _$SektorFromJson;

}