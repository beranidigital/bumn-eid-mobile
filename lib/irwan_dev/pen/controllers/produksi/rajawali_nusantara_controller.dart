import 'package:get/get.dart';

class RajawaliNusantaraController extends GetxController {
  int kondisiPenjualan = 0;
  int kondisiKetersediaan = 0;

  void setKondisiPenjualan(val) {
    kondisiPenjualan = val;
    update();
  }

  void setKondisiKetersediaan(val) {
    kondisiKetersediaan = val;
    update();
  }
}
