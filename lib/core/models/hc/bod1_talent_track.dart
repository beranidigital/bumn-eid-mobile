import 'package:bumn_eid/core/api/response/response_object.dart';
import 'package:json_annotation/json_annotation.dart';

part 'bod1_talent_track.g.dart';

@JsonSerializable(createToJson: false)
class BOD1TalentTrack extends ResponseObject {

  @JsonKey(name: 'NAMA_KRITERIA')
  final String kriteria;

  @JsonKey(name: 'VALUE')
  final String value;

  BOD1TalentTrack({
    this.kriteria,
    this.value,
  });

  factory BOD1TalentTrack.fromJson(Map<String, dynamic> json) =>
      _$BOD1TalentTrackFromJson(json);

  static get serializer => _$BOD1TalentTrackFromJson;

}