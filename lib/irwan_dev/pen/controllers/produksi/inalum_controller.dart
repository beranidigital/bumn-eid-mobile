import 'package:get/get.dart';

class InalumController extends GetxController {
  int kondisiKinerja = 0;
  int kondisiTren = 0;
  int kondisiHarga = 0;

  void setKondisiKinerja(int val) {
    kondisiKinerja = val;
    update();
  }

  void setKondisiTren(int val) {
    kondisiTren = val;
    update();
  }

  void setKondisiHarga(int val) {
    kondisiHarga = val;
    update();
  }
}
