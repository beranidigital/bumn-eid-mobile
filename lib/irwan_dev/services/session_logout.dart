class SessionLogout {
  DateTime now = DateTime.now();
  Future<int> methodSession(int tgl, int bln, int thn) async {
    final datestart = DateTime(thn, bln, tgl);
    final dateend = DateTime(now.year, now.month, now.day);
    // print(dateend.difference(datestart).inDays);

    // print("$tgl -- $bln -- $thn");
    // print("${now.day} -- ${now.month} -- ${now.year}");

    if (now.day < tgl + 3) {
      if ((dateend.difference(datestart).inDays) < 4) {
        print("2");
        return 0;
      } else if (now.month > bln) {
        print("3");
        return 1;
      } else if (now.year > thn) {
        print("4");
        return 1;
      } else {
        print("5");
        return 0;
      }
    } else {
      print("1");
      return 1;
    }
  }
}
