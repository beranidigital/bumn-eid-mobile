import 'package:bumn_eid/core/api/response/response_object.dart';
import 'package:json_annotation/json_annotation.dart';

part 'grafik_potret_kerja.g.dart';

@JsonSerializable(createToJson: false)
class GrafikPotretTugas extends ResponseObject {

  @JsonKey(name: 'less_one_year')
  final int lessOneYear;

  @JsonKey(name: 'one_two_years')
  final int oneTwoYears;

  @JsonKey(name: 'two_three_years')
  final int twoThreeYears;

  @JsonKey(name: 'three_four_years')
  final int threeFourYears;

  @JsonKey(name: 'four_five_years')
  final int fourFiveYears;

  GrafikPotretTugas({this.lessOneYear, this.oneTwoYears, this. twoThreeYears, this.threeFourYears, this.fourFiveYears});

  factory GrafikPotretTugas.fromJson(Map<String, dynamic> json) =>
      _$GrafikPotretTugasFromJson(json);

  static get serializer => _$GrafikPotretTugasFromJson;

}