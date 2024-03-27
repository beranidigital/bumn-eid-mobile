import 'package:bumn_eid/core/api/response/response_object.dart';
import 'package:json_annotation/json_annotation.dart';

part 'bod1_talent_peminatan.g.dart';

@JsonSerializable(createToJson: false)
class BOD1TalentPeminatan extends ResponseObject {

  @JsonKey(name: 'POSISI')
  final String posisi;

  @JsonKey(name: 'LAINNYA')
  final String lainnya;

  BOD1TalentPeminatan({
    this.posisi,
    this.lainnya
  });

  factory BOD1TalentPeminatan.fromJson(Map<String, dynamic> json) =>
      _$BOD1TalentPeminatanFromJson(json);

  static get serializer => _$BOD1TalentPeminatanFromJson;

}