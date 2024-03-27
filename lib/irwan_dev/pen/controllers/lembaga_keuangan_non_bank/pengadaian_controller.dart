import 'package:get/get.dart';

class PengadaianController extends GetxController {
  int kondisiLoan = 0;
  int kondisiCustomer = 0;

  void setKondisiLoan(val) {
    kondisiLoan = val;
    update();
  }

  void setKondisiCustomer(val) {
    kondisiCustomer = val;
    update();
  }
}
