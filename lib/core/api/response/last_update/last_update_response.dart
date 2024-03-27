import 'package:bumn_eid/core/api/response/response_object.dart';
import 'package:bumn_eid/core/models/common/last_update.dart';
import 'package:json_annotation/json_annotation.dart';

part 'last_update_response.g.dart';

@JsonSerializable(createToJson: false)
class LastUpdateResponse extends ResponseObject {
  @JsonKey(name: 'success')
  final bool success;

  @JsonKey(name: 'message')
  final String message;

  @JsonKey(name: 'data')
  final List<LastUpdate> data;

  LastUpdateResponse({this.success, this.message, this.data});

  factory LastUpdateResponse.fromJson(Map<String, dynamic> json) =>
      _$LastUpdateResponseFromJson(json);

  static get serializer => _$LastUpdateResponseFromJson;
}