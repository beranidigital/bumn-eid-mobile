import 'package:get/get.dart';

class BulogController extends GetxController {
  int kondisiKetersediaan = 0;

  void setKondisiKetersediaan(val) {
    kondisiKetersediaan = val;
    update();
  }
}
