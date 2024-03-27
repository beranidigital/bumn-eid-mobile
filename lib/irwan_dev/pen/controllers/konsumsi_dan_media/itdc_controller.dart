import 'package:get/get.dart';

class ITDCController extends GetxController {
  int kondisiKategori = 0;

  void setKKondisiKategori(int val) {
    kondisiKategori = val;
    update();
  }
}
