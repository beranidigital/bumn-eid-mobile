import 'package:bumn_eid/core/api/response/response_object.dart';
import 'package:bumn_eid/core/models/common/anak_perusahaan_deni.dart';
import 'package:bumn_eid/core/models/hc/search_people_item.dart';
import 'package:json_annotation/json_annotation.dart';

part 'search_item_response.g.dart';

@JsonSerializable(createToJson: false)
class SearchItemResponse extends ResponseObject {
  @JsonKey(name: 'success')
  final bool success;

  @JsonKey(name: 'message')
  final String message;

  @JsonKey(name: 'data_induk')
  final List<SearchPeopleItem> item;

  @JsonKey(name: 'data_anak')
  final List<SearchPeopleItem> itemAnak;

  @JsonKey(name: 'data_cucu')
  final List<SearchPeopleItem> itemCucu;

  @JsonKey(name: 'data_talent_pool')
  final List<SearchPeopleItem> itemTalentPool;

  SearchItemResponse({this.success, this.message, this.item, this.itemAnak, this.itemCucu, this.itemTalentPool});

  factory SearchItemResponse.fromJson(Map<String, dynamic> json) =>
      _$SearchItemResponseFromJson(json);

  static get serializer => _$SearchItemResponseFromJson;
}