import 'package:get/get.dart';

class AngkasaPuraController extends GetxController {
  int kondisiLintas = 0;

  void setKondisiLintas(val) {
    kondisiLintas = val;
    update();
  }
}
