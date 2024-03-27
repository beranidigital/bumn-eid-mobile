import 'package:bumn_eid/core/api/response/response_object.dart';
import 'package:bumn_eid/core/models/hc/bod1_talent_assessment.dart';
import 'package:bumn_eid/core/models/hc/bod1_talent_education.dart';
import 'package:bumn_eid/core/models/hc/bod1_talent_jabatan.dart';
import 'package:bumn_eid/core/models/hc/bod1_talent_kesehatan.dart';
import 'package:bumn_eid/core/models/hc/bod1_talent_peminatan.dart';
import 'package:bumn_eid/core/models/hc/bod1_talent_penghargaan.dart';
import 'package:bumn_eid/core/models/hc/bod1_talent_performance.dart';
import 'package:bumn_eid/core/models/hc/bod1_talent_personal.dart';
import 'package:bumn_eid/core/models/hc/bod1_talent_photo.dart';
import 'package:bumn_eid/core/models/hc/bod1_talent_summary.dart';
import 'package:bumn_eid/core/models/hc/bod1_talent_tani.dart';
import 'package:bumn_eid/core/models/hc/bod1_talent_track.dart';
import 'package:bumn_eid/core/models/hc/talent_additional_data.dart';
import 'package:json_annotation/json_annotation.dart';

import 'bod1_talent_lkhpn.dart';

part 'bod1_talent.g.dart';

@JsonSerializable(createToJson: false)
class BOD1Talent extends ResponseObject {

  @JsonKey(name: 'personal')
  final List<BOD1TalentPersonal> personal;

  @JsonKey(name: 'perf')
  final List<BOD1TalentPerformance> performance;

  @JsonKey(name: 'kes')
  final List<BOD1TalentKesehatan> kesehatan;

  @JsonKey(name: 'lhkpn')
  final List<BOD1TalentLkhpn> lhkpn;

  @JsonKey(name: 'track')
  final List<BOD1TalentTrack> track;

  @JsonKey(name: 'tani')
  final List<BOD1TalentTani> tani;

  @JsonKey(name: 'summary')
  final List<BOD1TalentSummary> summary;

  @JsonKey(name: 'pendidikan')
  final List<BOD1TalentEducation> pendidikan;

  @JsonKey(name: 'riwayatjabatan')
  final List<BOD1TalentJabatan> jabatan;

  @JsonKey(name: 'penghargaan')
  final List<BOD1TalentPenghargaan> penghargaan;

  @JsonKey(name: 'peminatan')
  final List<BOD1TalentPeminatan> peminatan;

  @JsonKey(name: 'assmkomp_domestic')
  final List<BOD1TalentAssessment> assessmentDomestic;

  @JsonKey(name: 'assmkomp_global')
  final List<BOD1TalentAssessment> assessmentGlobal;

  @JsonKey(name: 'foto')
  final List<BOD1TalentPhoto> photos;

  BOD1Talent({
    this.penghargaan,
    this.summary,
    this.jabatan,
    this.pendidikan,
    this.assessmentDomestic,
    this.assessmentGlobal,
    this.kesehatan,
    this.lhkpn,
    this.peminatan,
    this.performance,
    this.personal,
    this.tani,
    this.track,
    this.photos
  });

  factory BOD1Talent.fromJson(Map<String, dynamic> json) =>
      _$BOD1TalentFromJson(json);

  static get serializer => _$BOD1TalentFromJson;

}