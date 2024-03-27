import 'dart:convert';

class BumnProfiles {
  List<String> name;
  List<String> logo;
  BumnProfiles({
    this.name,
    this.logo,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'logo': logo,
    };
  }

  factory BumnProfiles.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return BumnProfiles(
      name: List<String>.from(map['name']),
      logo: List<String>.from(map['logo']),
    );
  }

  String toJson() => json.encode(toMap());

  factory BumnProfiles.fromJson(String source) =>
      BumnProfiles.fromMap(json.decode(source));
}

class Summary {
  int cosmic_index;
  int total_perimeter;
  int total_event;
  Summary({
    this.cosmic_index,
    this.total_perimeter,
    this.total_event,
  });

  Map<String, dynamic> toMap() {
    return {
      'cosmic_index': cosmic_index,
      'total_perimeter': total_perimeter,
      'total_event': total_event,
    };
  }

  factory Summary.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Summary(
      cosmic_index: map['cosmic_index'],
      total_perimeter: map['total_perimeter'],
      total_event: map['total_event'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Summary.fromJson(String source) =>
      Summary.fromMap(json.decode(source));
}

class SumPerkembanganKasus {
  int terinfeksi;
  int sembuh;
  int meninggal;
  String last_updated;
  SumPerkembanganKasus({
    this.terinfeksi,
    this.sembuh,
    this.meninggal,
    this.last_updated,
  });

  Map<String, dynamic> toMap() {
    return {
      'terinfeksi': terinfeksi,
      'sembuh': sembuh,
      'meninggal': meninggal,
      'last_updated': last_updated,
    };
  }

  factory SumPerkembanganKasus.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return SumPerkembanganKasus(
      terinfeksi: map['terinfeksi'],
      sembuh: map['sembuh'],
      meninggal: map['meninggal'],
      last_updated: map['last_updated'],
    );
  }

  String toJson() => json.encode(toMap());

  factory SumPerkembanganKasus.fromJson(String source) =>
      SumPerkembanganKasus.fromMap(json.decode(source));
}

class SummaryProgressVaksin {
  int total_bumn;
  int total_tervaksin;
  String last_updated;
  SummaryProgressVaksin({
    this.total_bumn,
    this.total_tervaksin,
    this.last_updated,
  });

  Map<String, dynamic> toMap() {
    return {
      'total_bumn': total_bumn,
      'total_tervaksin': total_tervaksin,
      'last_updated': last_updated,
    };
  }

  factory SummaryProgressVaksin.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return SummaryProgressVaksin(
      total_bumn: map['total_bumn'],
      total_tervaksin: map['total_tervaksin'],
      last_updated: map['last_updated'],
    );
  }

  String toJson() => json.encode(toMap());

  factory SummaryProgressVaksin.fromJson(String source) =>
      SummaryProgressVaksin.fromMap(json.decode(source));
}

class PerkembanganKasus {
  String status_kasus2;
  int total;
  PerkembanganKasus({
    this.status_kasus2,
    this.total,
  });

  Map<String, dynamic> toMap() {
    return {
      'status_kasus2': status_kasus2,
      'total': total,
    };
  }

  factory PerkembanganKasus.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return PerkembanganKasus(
      status_kasus2: map['status_kasus2'],
      total: map['total'],
    );
  }

  String toJson() => json.encode(toMap());

  factory PerkembanganKasus.fromJson(String source) =>
      PerkembanganKasus.fromMap(json.decode(source));
}

class CovidSafeProtokol {
  String protokol;
  String filepath;
  CovidSafeProtokol({
    this.protokol,
    this.filepath,
  });

  Map<String, dynamic> toMap() {
    return {
      'protokol': protokol,
      'filepath': filepath,
    };
  }

  factory CovidSafeProtokol.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return CovidSafeProtokol(
      protokol: map['protokol'],
      filepath: map['filepath'],
    );
  }

  String toJson() => json.encode(toMap());

  factory CovidSafeProtokol.fromJson(String source) =>
      CovidSafeProtokol.fromMap(json.decode(source));
}

class CosmicIndex {
  String tanggal;
  int cosmic_index;
  CosmicIndex({
    this.tanggal,
    this.cosmic_index,
  });

  Map<String, dynamic> toMap() {
    return {
      'tanggal': tanggal,
      'cosmic_index': cosmic_index,
    };
  }

  factory CosmicIndex.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return CosmicIndex(
      tanggal: map['tanggal'],
      cosmic_index: map['cosmic_index'],
    );
  }

  String toJson() => json.encode(toMap());

  factory CosmicIndex.fromJson(String source) =>
      CosmicIndex.fromMap(json.decode(source));
}

class PegawaiTerdampak {
  String nama;
  String status_kasus2;
  PegawaiTerdampak({
    this.nama,
    this.status_kasus2,
  });

  Map<String, dynamic> toMap() {
    return {
      'nama': nama,
      'status_kasus2': status_kasus2,
    };
  }

  factory PegawaiTerdampak.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return PegawaiTerdampak(
      nama: map['nama'],
      status_kasus2: map['status_kasus2'],
    );
  }

  String toJson() => json.encode(toMap());

  factory PegawaiTerdampak.fromJson(String source) =>
      PegawaiTerdampak.fromMap(json.decode(source));
}

class Events {
  int id;
  String nama_kegiatan;
  Events({
    this.id,
    this.nama_kegiatan,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nama_kegiatan': nama_kegiatan,
    };
  }

  factory Events.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Events(
      id: map['id'],
      nama_kegiatan: map['nama_kegiatan'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Events.fromJson(String source) => Events.fromMap(json.decode(source));
}

class KategoriPerimeters {
  String kategori;
  int total;
  KategoriPerimeters({
    this.kategori,
    this.total,
  });

  Map<String, dynamic> toMap() {
    return {
      'kategori': kategori,
      'total': total,
    };
  }

  factory KategoriPerimeters.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return KategoriPerimeters(
      kategori: map['kategori'],
      total: map['total'],
    );
  }

  String toJson() => json.encode(toMap());

  factory KategoriPerimeters.fromJson(String source) =>
      KategoriPerimeters.fromMap(json.decode(source));
}
