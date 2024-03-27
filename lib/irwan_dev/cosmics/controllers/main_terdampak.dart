import 'package:get/get.dart';

class MainTerdampakController extends GetxController {
  //controller choice
  int choice = 1;

  void setChoice(int val) {
    choice = val;
    update();
  }

  //controller filter
  String statusKasus = "Kasus 1";
  String tanggal = "17";
  String wamen = "Pak Irwan";
  String classs = "a5";
  String cluster = "Cluster 1";
  String statusPegawai = "Status 1";
  int groupTotalKasus = 0;

  void setStatusKasus(String val) {
    statusKasus = val;
    update();
  }

  void setTanggal(String val) {
    tanggal = val;
    update();
  }

  void setWamen(String val) {
    wamen = val;
    update();
  }

  void setClass(String val) {
    classs = val;
    update();
  }

  void setCluster(String val) {
    cluster = val;
    update();
  }

  void setStatusPegawai(String val) {
    statusPegawai = val;
    update();
  }

  void setGroupTotalKasus(int val) {
    groupTotalKasus = val;
    update();
  }
}
