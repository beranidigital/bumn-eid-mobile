import 'package:get/get.dart';

class MainVaksinasiController extends GetxController {
  //controller filter
  int grouptStatusKasus = 0;
  int groupTotal = 0;
  String cluster = "Adakah 1";
  String statusPegawai = "2020";

  void setCluster(String val) {
    cluster = val;
    update();
  }

  void setStatusPegawai(String val) {
    statusPegawai = val;
    update();
  }

  void setGroupStatusKasus(int val) {
    grouptStatusKasus = val;
    update();
  }

  void setGroupTotal(int val) {
    groupTotal = val;
    update();
  }
}
