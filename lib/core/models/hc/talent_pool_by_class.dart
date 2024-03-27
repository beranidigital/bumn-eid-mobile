import 'package:bumn_eid/core/api/response/response_object.dart';
import 'package:json_annotation/json_annotation.dart';

part 'talent_pool_by_class.g.dart';

@JsonSerializable(createToJson: false)
class TalentPoolByClass extends ResponseObject {

  @JsonKey(name: 'kelas_bumn')
  final String kelasBumn;

  @JsonKey(name: 'jumlah')
  final int jumlah;

  TalentPoolByClass({this.jumlah, this.kelasBumn});

  factory TalentPoolByClass.fromJson(Map<String, dynamic> json) =>
      _$TalentPoolByClassFromJson(json);

  static get serializer => _$TalentPoolByClassFromJson;

}