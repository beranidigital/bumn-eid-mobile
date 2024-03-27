import 'package:bumn_eid/core/api/response/response_object.dart';
import 'package:json_annotation/json_annotation.dart';

part 'bod1_talent_photo.g.dart';

@JsonSerializable(createToJson: false)
class BOD1TalentPhoto extends ResponseObject {

  @JsonKey(name: 'path_foto')
  final String path;

  @JsonKey(name: 'type')
  final String type;

  BOD1TalentPhoto({
    this.path,
    this.type,
  });

  factory BOD1TalentPhoto.fromJson(Map<String, dynamic> json) =>
      _$BOD1TalentPhotoFromJson(json);

  static get serializer => _$BOD1TalentPhotoFromJson;

}