import 'package:get/get.dart';

class PertaminaController extends GetxController {
  int nilaiAwal = 0;

  void setNilaiAwal(int val) {
    nilaiAwal = val;
    update();
  }
}
