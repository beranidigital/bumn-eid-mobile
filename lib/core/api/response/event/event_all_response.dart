import 'package:bumn_eid/core/api/response/response_object.dart';
import 'package:bumn_eid/core/models/event/event_item.dart';
import 'package:json_annotation/json_annotation.dart';

part 'event_all_response.g.dart';

@JsonSerializable(createToJson: false)
class EventAllResponse extends ResponseObject {
  @JsonKey(name: 'success')
  final bool success;

  @JsonKey(name: 'message')
  final String message;

  @JsonKey(name: 'data')
  final List<EventItem> data;


  EventAllResponse({this.success, this.message, this.data});

  factory EventAllResponse.fromJson(Map<String, dynamic> json) =>
      _$EventAllResponseFromJson(json);

  static get serializer => _$EventAllResponseFromJson;
}