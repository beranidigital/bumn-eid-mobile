import 'dart:convert';

import 'package:bumn_eid/irwan_dev/cosmics/models/detail_model/summary_perkembanganKasus.dart';

class SummaryAll {
  String average_cosmic_index;
  int total_perimeter;
  int events;
  int vaksin;
  SummaryPerkembanganKasus perkembangan_kasus;
  SummaryAll({
    this.average_cosmic_index,
    this.total_perimeter,
    this.events,
    this.vaksin,
    this.perkembangan_kasus,
  });

  Map<String, dynamic> toMap() {
    return {
      'average_cosmic_index': average_cosmic_index,
      'total_perimeter': total_perimeter,
      'events': events,
      'vaksin': vaksin,
      'perkembangan_kasus': perkembangan_kasus?.toMap(),
    };
  }

  factory SummaryAll.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return SummaryAll(
      average_cosmic_index: map['average_cosmic_index'],
      total_perimeter: map['total_perimeter'],
      events: map['events'],
      vaksin: map['vaksin'],
      perkembangan_kasus:
          SummaryPerkembanganKasus.fromMap(map['perkembangan_kasus']),
    );
  }

  String toJson() => json.encode(toMap());

  factory SummaryAll.fromJson(String source) =>
      SummaryAll.fromMap(json.decode(source));
}
