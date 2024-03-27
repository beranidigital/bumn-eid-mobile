import 'package:bumn_eid/core/api/response/response_object.dart';
import 'package:json_annotation/json_annotation.dart';

part 'bod1_class.g.dart';

@JsonSerializable(createToJson: false)
class BOD1Class extends ResponseObject {

  @JsonKey(name: 'kelas_bumn')
  final String kelas;

  @JsonKey(name: 'jumlah')
  final int jumlahBOD1;

  BOD1Class({this.kelas, this.jumlahBOD1});

  factory BOD1Class.fromJson(Map<String, dynamic> json) =>
      _$BOD1ClassFromJson(json);

  static get serializer => _$BOD1ClassFromJson;

}