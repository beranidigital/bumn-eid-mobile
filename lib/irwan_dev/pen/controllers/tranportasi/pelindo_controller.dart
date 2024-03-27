import 'package:get/get.dart';

class PelindoController extends GetxController {
  int kondisiPergerakan = 0;
  int kondisiSummary = 0;
  int kondisiCabang = 0;

  void setKondisiPergerakan(val) {
    kondisiPergerakan = val;
    update();
  }

  void setKondisiSummary(val) {
    kondisiSummary = val;
    update();
  }

  void setKondisiCabang(val) {
    kondisiCabang = val;
    update();
  }
}
