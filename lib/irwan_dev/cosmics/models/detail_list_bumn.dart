import 'dart:convert';

import 'package:bumn_eid/irwan_dev/cosmics/models/detail_model/detail_list_bumn.dart';

class DetailListBumn {
  List<BumnProfiles> bumn_profiles;
  List<Summary> summary;
  List<SumPerkembanganKasus> summaryPerkembanganKasus;
  List<SummaryProgressVaksin> summaryProgressVaksin;
  List<CovidSafeProtokol> covidSafeProtokol;
  List<PerkembanganKasus> perkembangan_kasus;
  List<CosmicIndex> cosmic_index;
  List<PegawaiTerdampak> pegawai_terdampak;
  List<Events> events;
  List<KategoriPerimeters> kategori_perimeters;
  DetailListBumn({
    this.bumn_profiles,
    this.summary,
    this.summaryPerkembanganKasus,
    this.summaryProgressVaksin,
    this.covidSafeProtokol,
    this.perkembangan_kasus,
    this.cosmic_index,
    this.pegawai_terdampak,
    this.events,
    this.kategori_perimeters,
  });
}
