import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainPerusahaanController extends GetxController {
  int choicePerusahaan = 0;

  void setChoicePerusahaan(int val) {
    choicePerusahaan = val;
    update(['refreshChoicePerusahaan']);
  }

  void setValueChoice(int val) {
    choicePerusahaan = val;
  }

  void refreshList() {
    update(['refreshList']);
  }

  void refreshFetchList() {
    update(['refreshFetchList']);
  }

  void refreshChoicePerusahaan() {
    update(['refreshChoicePerusahaan']);
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
    update(['refreshChoicePerusahaan']);
  }

  void refreshFilter() {
    update(['refreshFilter']);
  }

  void setPath(String val) {
    path = val;
  }

  Map<String, dynamic> listData = new Map<String, dynamic>().obs;

  void setListDataObs(Map<String, dynamic> dataList) {
    listData = dataList;
  }

  void refreshMainList() {
    update(['refreshMainList']);
  }

  int currentPage = 1;

  void setCurrentPage(int val) {
    currentPage = val;
  }

  void addCurrentPage() {
    currentPage++;
  }

  String bumnName = "";
  String kelas = "";
  String wamen = "";
  String cluster = "";

  void setResetFilter() {
    bumnName = "";
    kelas = "";
    wamen = "";
    cluster = "";
  }

  set setWamen(String value) => this.wamen = value;
  set setKelas(String value) => this.kelas = value;
  set setCluster(String value) => this.cluster = value;
  set setBumnName(String value) => this.bumnName = value;
}
