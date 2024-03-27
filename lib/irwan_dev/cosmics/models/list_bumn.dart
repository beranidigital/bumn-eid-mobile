import 'dart:convert';

class ListBumn {
  int id;
  String bumn_id;
  String bumn_name;
  String cluster_bumn;
  String wamen_bumn;
  String kelas_bumn;
  int cosmic_index;
  String pemenuhan_protokol;
  String pemenuhan_ceklist_monitoring;
  String pemenuhan_eviden;
  String week_start;
  String week_end;
  ListBumn({
    this.id,
    this.bumn_id,
    this.bumn_name,
    this.cluster_bumn,
    this.wamen_bumn,
    this.kelas_bumn,
    this.cosmic_index,
    this.pemenuhan_protokol,
    this.pemenuhan_ceklist_monitoring,
    this.pemenuhan_eviden,
    this.week_start,
    this.week_end,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'bumn_id': bumn_id,
      'bumn_name': bumn_name,
      'cluster_bumn': cluster_bumn,
      'wamen_bumn': wamen_bumn,
      'kelas_bumn': kelas_bumn,
      'cosmic_index': cosmic_index,
      'pemenuhan_protokol': pemenuhan_protokol,
      'pemenuhan_ceklist_monitoring': pemenuhan_ceklist_monitoring,
      'pemenuhan_eviden': pemenuhan_eviden,
      'week_start': week_start,
      'week_end': week_end,
    };
  }

  factory ListBumn.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
  
    return ListBumn(
      id: map['id'],
      bumn_id: map['bumn_id'],
      bumn_name: map['bumn_name'],
      cluster_bumn: map['cluster_bumn'],
      wamen_bumn: map['wamen_bumn'],
      kelas_bumn: map['kelas_bumn'],
      cosmic_index: map['cosmic_index'],
      pemenuhan_protokol: map['pemenuhan_protokol'],
      pemenuhan_ceklist_monitoring: map['pemenuhan_ceklist_monitoring'],
      pemenuhan_eviden: map['pemenuhan_eviden'],
      week_start: map['week_start'],
      week_end: map['week_end'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ListBumn.fromJson(String source) => ListBumn.fromMap(json.decode(source));
}
