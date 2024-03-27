import 'package:get/get.dart';

class PTPNController extends GetxController {
  int kondisiKinerja = 0;

  void setKondisiKinerja(val) {
    kondisiKinerja = val;
    update();
  }
}
