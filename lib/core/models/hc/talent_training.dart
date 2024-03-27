import 'package:bumn_eid/core/api/response/response_object.dart';
import 'package:json_annotation/json_annotation.dart';

part 'talent_training.g.dart';

@JsonSerializable()
class TalentTraining extends ResponseObject {

  @JsonKey(name: 'i_user')
  final int idUser;

  @JsonKey(name: 'i_pelatihan')
  final int idTraining;

  @JsonKey(name: 'i_bidang')
  final int idBidang;

  @JsonKey(name: 'e_instansi')
  final String organizer;

  @JsonKey(name: 'e_alamat')
  final String address;

  @JsonKey(name: 'i_tahun')
  final String tahun;

  @JsonKey(name: 'n_lama')
  final String lama;

  @JsonKey(name: 'n_bidang')
  final String bidang;

  @JsonKey(name: 'n_pelatihan')
  final String namaPelatihan;

  TalentTraining({
    this.idUser,
    this.bidang,
    this.idBidang,
    this.idTraining,
    this.organizer,
    this.tahun,
    this.address,
    this.lama,
    this.namaPelatihan
  });

  factory TalentTraining.fromJson(Map<String, dynamic> json) =>
      _$TalentTrainingFromJson(json);

  static get serializer => _$TalentTrainingFromJson;

}