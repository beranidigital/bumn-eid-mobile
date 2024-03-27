import 'package:get/get.dart';

class BankController extends GetxController {
  int kondisiSubsidi = 0;
  int kondisiBantuan = 0;

  void setKondisiSubsidi(val) {
    kondisiSubsidi = val;
    update();
  }

  void setKondisiBantuan(val) {
    kondisiBantuan = val;
    update();
  }
}
