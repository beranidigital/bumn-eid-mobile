import 'dart:convert';

class SummaryPerkembanganKasus {
  int terinfeksi;
  int sembuh;
  int meninggal;
  String recovery_rate;
  String fatality_rate;
  SummaryPerkembanganKasus({
    this.terinfeksi,
    this.sembuh,
    this.meninggal,
    this.recovery_rate,
    this.fatality_rate,
  });

  Map<String, dynamic> toMap() {
    return {
      'terinfeksi': terinfeksi,
      'sembuh': sembuh,
      'meninggal': meninggal,
      'recovery_rate': recovery_rate,
      'fatality_rate': fatality_rate,
    };
  }

  factory SummaryPerkembanganKasus.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return SummaryPerkembanganKasus(
      terinfeksi: map['terinfeksi'],
      sembuh: map['sembuh'],
      meninggal: map['meninggal'],
      recovery_rate: map['recovery_rate'],
      fatality_rate: map['fatality_rate'],
    );
  }

  String toJson() => json.encode(toMap());

  factory SummaryPerkembanganKasus.fromJson(String source) =>
      SummaryPerkembanganKasus.fromMap(json.decode(source));
}
