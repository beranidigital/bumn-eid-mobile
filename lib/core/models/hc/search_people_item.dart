import 'package:bumn_eid/core/api/response/response_object.dart';
import 'package:bumn_eid/ui/components/single_list_view.dart';
import 'package:json_annotation/json_annotation.dart';

part 'search_people_item.g.dart';

@JsonSerializable(createToJson: false)
class SearchPeopleItem extends ResponseObject with SingleListItem {

  @JsonKey(name: 'nama')
  final String nama;

  @JsonKey(name: 'nama_lengkap')
  final String nama_lengkap;

  @JsonKey(name: 'nama_anak')
  final String namaAnak;

  @JsonKey(name: 'nama_cucu')
  final String namaCucu;

  @JsonKey(name: 'pangkat')
  final String pangkat;

  @JsonKey(name: 'id')
  final int id;

  @JsonKey(name: 'id_angka')
  final String companyId;

  SearchPeopleItem({this.nama, this.companyId, this.pangkat, this.id, this.nama_lengkap, this.namaAnak, this.namaCucu});

  factory SearchPeopleItem.fromJson(Map<String, dynamic> json) =>
      _$SearchPeopleItemFromJson(json);

  static get serializer => _$SearchPeopleItemFromJson;

  @override
  String getTitle() {
    return nama;
  }

}