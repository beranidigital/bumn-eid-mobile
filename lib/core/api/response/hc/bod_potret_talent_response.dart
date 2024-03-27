import 'package:bumn_eid/core/api/response/response_object.dart';
import 'package:bumn_eid/core/models/hc/talent_bahasa.dart';
import 'package:bumn_eid/core/models/hc/talent_certification.dart';
import 'package:bumn_eid/core/models/hc/talent_detail.dart';
import 'package:bumn_eid/core/models/hc/talent_family.dart';
import 'package:bumn_eid/core/models/hc/talent_karir.dart';
import 'package:bumn_eid/core/models/hc/talent_pendidikan.dart';
import 'package:bumn_eid/core/models/hc/talent_personal.dart';
import 'package:bumn_eid/core/models/hc/talent_prestasi.dart';
import 'package:bumn_eid/core/models/hc/talent_training.dart';
import 'package:json_annotation/json_annotation.dart';

part 'bod_potret_talent_response.g.dart';

@JsonSerializable(createToJson: false)
class BODPotretTalentResponse extends ResponseObject {
  @JsonKey(name: 'success')
  final bool success;

  @JsonKey(name: 'message')
  final String message;

  @JsonKey(name: 'total data')
  final int totalData;

  @JsonKey(name: 'personal')
  final List<TalentPersonal> personalData;

  @JsonKey(name: 'keluarga')
  final List<TalentFamily> families;

  @JsonKey(name: 'sertifikasi')
  final List<TalentCertification> certifications;

  @JsonKey(name: 'data')
  final List<TalentDetail> data;

  @JsonKey(name: 'pelatihan')
  final List<TalentTraining> trainings;

  @JsonKey(name: 'karir')
  final List<TalentKarir> karir;

  @JsonKey(name: 'pendidikan')
  final List<TalentPendidikan> pendidikan;

  @JsonKey(name: 'bahasa')
  final List<TalentBahasa> bahasa;

  @JsonKey(name: 'prestasi')
  final List<TalentPrestasi> prestasi;

  BODPotretTalentResponse({this.success, this.message, this.personalData, this.pendidikan, this.bahasa, this.prestasi,
    this.families, this.certifications, this.totalData, this.data, this.trainings, this.karir});

  factory BODPotretTalentResponse.fromJson(Map<String, dynamic> json) =>
      _$BODPotretTalentResponseFromJson(json);

  static get serializer => _$BODPotretTalentResponseFromJson;
}