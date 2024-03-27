import 'dart:convert';

import 'package:bumn_eid/irwan_dev/cosmics/models/detail_model/summary_all.dart';
import 'package:http/http.dart' as http;

class SummaryMainPage1 {
  List<SummaryAll> summaryAll;
  SummaryMainPage1({
    this.summaryAll,
  });

  Map<String, dynamic> toMap() {
    return {
      'summaryAll': summaryAll?.map((x) => x?.toMap())?.toList(),
    };
  }

  factory SummaryMainPage1.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return SummaryMainPage1(
      summaryAll: List<SummaryAll>.from(
          map['summaryAll']?.map((x) => SummaryAll.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory SummaryMainPage1.fromJson(String source) =>
      SummaryMainPage1.fromMap(json.decode(source));
}
