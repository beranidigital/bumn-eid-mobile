import 'package:bumn_eid/core/api/response/response_object.dart';
import 'package:bumn_eid/ui/utils/widget_utils.dart';
import 'package:json_annotation/json_annotation.dart';

part 'event_item.g.dart';

@JsonSerializable()
class EventItem extends ResponseObject {

  @JsonKey(name: 'id')
  final int id;

  @JsonKey(name: 'date')
  final String date;

  @JsonKey(name: 'event_name')
  final String eventName;

  EventItem({
    this.id,
    this.date,
    this.eventName,
  });

  DateTime getDateTime() => parseDateTime(date);

  factory EventItem.fromJson(Map<String, dynamic> json) =>
      _$EventItemFromJson(json);

  static get serializer => _$EventItemFromJson;

}