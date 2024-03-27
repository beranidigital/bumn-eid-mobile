import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboardController extends GetxController {
  int choiceView = 0;

  void setChoiceView(int val) {
    choiceView = val;
    update(['mainDashboardView']);
  }

  List<IconData> iconFilter = [Icons.filter_list];
  List<String> titleFilter = ["Filter"];

  void setDataFilter(List<IconData> lsIcon, List<String> lsTitle) {
    iconFilter = lsIcon;
    titleFilter = lsTitle;
  }

  String path = "";
  void updateFilter(List<IconData> lsIcon, List<String> lsTitle, String val) {
    iconFilter.addAll(lsIcon);
    titleFilter.addAll(lsTitle);
    path = val;
    update(['mainMainDashboardView']);
  }

  void refreshFilter() {
    update(['refreshFilter']);
  }

  Map<String, dynamic> listData = new Map<String, dynamic>().obs;

  void setListDataObs(Map<String, dynamic> dataList) {
    listData = dataList;
  }

  String jenis_perusahaan = "";
  String valueJenisPerusahaan = "";
  String kategori = "";
  String valueKategori = "";
  String jk = "";
  String wamen = "";
  String kelas = "";
  String cluster = "";

  void setResetFilter() {
    jenis_perusahaan = "";
    // valueJenisPerusahaan = "";
    kategori = "";
    // valueKategori = "";
    jk = "";
    wamen = "";
    kelas = "";
    cluster = "";
  }

  set setJenisPerusahaan(String value) => this.jenis_perusahaan = value;
  set setValueJenisPerusahaan(String value) =>
      this.valueJenisPerusahaan = value;
  set setKategori(String value) => this.kategori = value;
  set setValueKategori(String value) => this.valueKategori = value;
  set setJk(String value) => this.jk = value;
  set setWamen(String value) => this.wamen = value;
  set setKelas(String value) => this.kelas = value;
  set setCluster(String value) => this.cluster = value;
}
