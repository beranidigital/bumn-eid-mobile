import 'dart:convert';

class BumnList {
  String id_angka;
  String bumn_name;
  int bod;
  int boc;
  int count;
  BumnList({
    this.id_angka,
    this.bumn_name,
    this.bod,
    this.boc,
    this.count,
  });

  Map<String, dynamic> toMap() {
    return {
      'id_angka': id_angka,
      'bumn_name': bumn_name,
      'bod': bod,
      'boc': boc,
      'count': count,
    };
  }

  factory BumnList.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return BumnList(
      id_angka: map['id_angka'],
      bumn_name: map['bumn_name'],
      bod: map['bod'],
      boc: map['boc'],
      count: map['count'],
    );
  }

  String toJson() => json.encode(toMap());

  factory BumnList.fromJson(String source) =>
      BumnList.fromMap(json.decode(source));
}

class BUMNListPagination {
  int current_page;
  int last_page;
  List<BumnList> data;
  BUMNListPagination({
    this.current_page,
    this.last_page,
    this.data,
  });

  Map<String, dynamic> toMap() {
    return {
      'current_page': current_page,
      'last_page': last_page,
      'data': data?.map((x) => x.toMap())?.toList(),
    };
  }

  factory BUMNListPagination.fromMap(Map<String, dynamic> map) {
    return BUMNListPagination(
      current_page: map['current_page'],
      last_page: map['last_page'],
      data: List<BumnList>.from(map['data']?.map((x) => BumnList.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory BUMNListPagination.fromJson(String source) =>
      BUMNListPagination.fromMap(json.decode(source));
}
