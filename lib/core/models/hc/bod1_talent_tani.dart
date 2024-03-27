import 'package:bumn_eid/core/api/response/response_object.dart';
import 'package:json_annotation/json_annotation.dart';

part 'bod1_talent_tani.g.dart';

@JsonSerializable(createToJson: false)
class BOD1TalentTani extends ResponseObject {

  @JsonKey(name: 'TANI')
  final String tani;

  BOD1TalentTani({
    this.tani,
  });

  factory BOD1TalentTani.fromJson(Map<String, dynamic> json) =>
      _$BOD1TalentTaniFromJson(json);

  static get serializer => _$BOD1TalentTaniFromJson;

}