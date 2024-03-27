import 'package:bumn_eid/core/api/response/response_object.dart';
import 'package:json_annotation/json_annotation.dart';

part 'talent_certification.g.dart';

@JsonSerializable()
class TalentCertification extends ResponseObject {

  @JsonKey(name: 'i_user')
  final int idUser;

  @JsonKey(name: 'i_sertifikasi')
  final int idCertification;

  @JsonKey(name: 'n_sertifikasi')
  final String certificationName;

  @JsonKey(name: 'i_bidang')
  final int idBidang;

  @JsonKey(name: 'd_mulai')
  final String start;

  @JsonKey(name: 'd_akhir')
  final String end;

  @JsonKey(name: 'e_penyelenggara')
  final String organizer;

  @JsonKey(name: 'e_telp')
  final String phone;

  @JsonKey(name: 'e_fax')
  final String fax;

  @JsonKey(name: 'e_desc')
  final String description;

  @JsonKey(name: 'n_bidang')
  final String bidang;

  TalentCertification({
    this.idUser,
    this.start,
    this.end,
    this.bidang,
    this.fax,
    this.certificationName,
    this.description,
    this.idBidang,
    this.idCertification,
    this.organizer,
    this.phone
  });

  factory TalentCertification.fromJson(Map<String, dynamic> json) =>
      _$TalentCertificationFromJson(json);

  static get serializer => _$TalentCertificationFromJson;

}