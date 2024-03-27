import 'dart:convert';

class SumTalentPool {
  int ready;
  int not_ready;
  int selected;
  int not_selected;
  int nominated;
  int not_nominated;
  int eligible;
  int not_eligible;
  SumTalentPool({
    this.ready,
    this.not_ready,
    this.selected,
    this.not_selected,
    this.nominated,
    this.not_nominated,
    this.eligible,
    this.not_eligible,
  });

  Map<String, dynamic> toMap() {
    return {
      'ready': ready,
      'not_ready': not_ready,
      'selected': selected,
      'not_selected': not_selected,
      'nominated': nominated,
      'not_nominated': not_nominated,
      'eligible': eligible,
      'not_eligible': not_eligible,
    };
  }

  factory SumTalentPool.fromMap(Map<String, dynamic> map) {
    return SumTalentPool(
      ready: map['ready'],
      not_ready: map['not_ready'],
      selected: map['selected'],
      not_selected: map['not_selected'],
      nominated: map['nominated'],
      not_nominated: map['not_nominated'],
      eligible: map['eligible'],
      not_eligible: map['not_eligible'],
    );
  }

  String toJson() => json.encode(toMap());

  factory SumTalentPool.fromJson(String source) =>
      SumTalentPool.fromMap(json.decode(source));
}

class GenderTalentPool {
  String jk;
  int total;
  GenderTalentPool({
    this.jk,
    this.total,
  });

  Map<String, dynamic> toMap() {
    return {
      'jk': jk,
      'total': total,
    };
  }

  factory GenderTalentPool.fromMap(Map<String, dynamic> map) {
    return GenderTalentPool(
      jk: map['jk'],
      total: map['total'],
    );
  }

  String toJson() => json.encode(toMap());

  factory GenderTalentPool.fromJson(String source) =>
      GenderTalentPool.fromMap(json.decode(source));
}

class AgamaTalentPool {
  String agama;
  int total;
  AgamaTalentPool({
    this.agama,
    this.total,
  });

  Map<String, dynamic> toMap() {
    return {
      'agama': agama,
      'total': total,
    };
  }

  factory AgamaTalentPool.fromMap(Map<String, dynamic> map) {
    return AgamaTalentPool(
      agama: map['agama'],
      total: map['total'],
    );
  }

  String toJson() => json.encode(toMap());

  factory AgamaTalentPool.fromJson(String source) =>
      AgamaTalentPool.fromMap(json.decode(source));
}

class KelUsiaTalentPool {
  int under_40;
  int between_41_50;
  int between_51_60;
  int above_60;
  KelUsiaTalentPool({
    this.under_40,
    this.between_41_50,
    this.between_51_60,
    this.above_60,
  });

  Map<String, dynamic> toMap() {
    return {
      'under_40': under_40,
      'between_41_50': between_41_50,
      'between_51_60': between_51_60,
      'above_60': above_60,
    };
  }

  factory KelUsiaTalentPool.fromMap(Map<String, dynamic> map) {
    return KelUsiaTalentPool(
      under_40: map['under_40'],
      between_41_50: map['between_41_50'],
      between_51_60: map['between_51_60'],
      above_60: map['above_60'],
    );
  }

  String toJson() => json.encode(toMap());

  factory KelUsiaTalentPool.fromJson(String source) =>
      KelUsiaTalentPool.fromMap(json.decode(source));
}

class TalentPoolSummary {
  SumTalentPool summary;
  List<GenderTalentPool> gender;
  KelUsiaTalentPool kelompok_usia;
  List<AgamaTalentPool> agama;
  TalentPoolSummary({
    this.summary,
    this.gender,
    this.kelompok_usia,
    this.agama,
  });

  Map<String, dynamic> toMap() {
    return {
      'summary': summary.toMap(),
      'gender': gender?.map((x) => x.toMap())?.toList(),
      'kelompok_usia': kelompok_usia.toMap(),
      'agama': agama?.map((x) => x.toMap())?.toList(),
    };
  }

  factory TalentPoolSummary.fromMap(Map<String, dynamic> map) {
    return TalentPoolSummary(
      summary: SumTalentPool.fromMap(map['summary']),
      gender: List<GenderTalentPool>.from(
          map['gender']?.map((x) => GenderTalentPool.fromMap(x))),
      kelompok_usia: KelUsiaTalentPool.fromMap(map['kelompok_usia']),
      agama: List<AgamaTalentPool>.from(
          map['agama']?.map((x) => AgamaTalentPool.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory TalentPoolSummary.fromJson(String source) =>
      TalentPoolSummary.fromMap(json.decode(source));
}
