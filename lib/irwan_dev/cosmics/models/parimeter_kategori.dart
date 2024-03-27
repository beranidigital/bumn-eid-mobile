import 'dart:convert';

class ParimeterKategori {
  int id_kategori;
  String kategori;
  int total_perimeter;
  ParimeterKategori({
    this.id_kategori,
    this.kategori,
    this.total_perimeter,
  });

  Map<String, dynamic> toMap() {
    return {
      'id_kategori': id_kategori,
      'kategori': kategori,
      'total_perimeter': total_perimeter,
    };
  }

  factory ParimeterKategori.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return ParimeterKategori(
      id_kategori: map['id_kategori'],
      kategori: map['kategori'],
      total_perimeter: map['total_perimeter'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ParimeterKategori.fromJson(String source) =>
      ParimeterKategori.fromMap(json.decode(source));
}
