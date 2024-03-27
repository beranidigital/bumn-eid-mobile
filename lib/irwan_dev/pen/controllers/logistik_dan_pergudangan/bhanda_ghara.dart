import 'package:get/get.dart';

class BhandaGharaController extends GetxController {
  int kondisiStok = 0;
  int kondisiPendapatan = 0;

  void setKondisiStok(val) {
    kondisiStok = val;
    update();
  }

  void setKondisiPendapatan(val) {
    kondisiPendapatan = val;
    update();
  }
}
