import 'package:bumn_eid/core/api/response/response_object.dart';
import 'package:json_annotation/json_annotation.dart';

part 'last_update.g.dart';

@JsonSerializable()
class LastUpdate extends ResponseObject {

  @JsonKey(name: 'page_name')
  final String pageName;

  @JsonKey(name: 'updated_date')
  final String lastUpdated;

  LastUpdate({
    this.pageName,
    this.lastUpdated,
  });

  factory LastUpdate.fromJson(Map<String, dynamic> json) =>
      _$LastUpdateFromJson(json);

  static get serializer => _$LastUpdateFromJson;

}