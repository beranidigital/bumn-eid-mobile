import 'dart:math';

import 'package:bumn_eid/core/models/common/sortable.dart';
import 'package:bumn_eid/core/models/finance/grafik_laba_rugi.dart';
import 'package:bumn_eid/core/redux/states/app_state/app_state.dart';
import 'package:bumn_eid/core/utils/constants.dart';
import 'package:bumn_eid/ui/pages/csr/common/penyebaran_wilayah_page/penyebaran_wilayah_page.dart';
import 'package:bumn_eid/ui/pages/finance/labarugi/laba_rugi_page/laba_rugi_page.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:redux/redux.dart';
import 'package:url_launcher/url_launcher.dart';

bool isSmallDevice(BuildContext context) {
  return MediaQuery.of(context).size.height <= Constants.smallDeviceHeight;
}

// Creates an empty view of the specified height
Widget buildEmptyView(int height) {
  return Container(height: height.toDouble());
}

// Extension functions on NavigatorState
extension NavState on NavigatorState {
  // Navigates back if possible
  void popNavigator() {
    if (this.canPop()) this.pop();
  }
}

Color randomizeColor() {
  final random = Random();
  final index = random.nextInt(Constants.randomColorList.length);
  return Constants.randomColorList[index];
}

Map<T, Color> categorizeToColor<T>(List<T> list) {
  Map<T, Color> ret = {};

  list.forEach((item) {
    int numOfTries = 0;
    Color color = randomizeColor();
    while (ret.containsValue(color) && numOfTries <= 20) {
      color = randomizeColor();
      numOfTries++;
    }
    ret[item] = color;
  });

  return ret;
}

Widget tableText(
    {@required String text, TextStyle textStyle, TextAlign textAlign}) {
  return Text(
    text,
    textAlign: textAlign ?? TextAlign.start,
    style: textStyle ?? TextStyle(color: Colors.black),
  );
}

Widget cell({
  @required String text,
  VoidCallback onTap,
  TextAlign textAlign,
  Color textColor,
}) {
  return TableCell(
    verticalAlignment: TableCellVerticalAlignment.middle,
    child: GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
        child: tableText(
            text: text,
            textStyle: onTap == null
                ? TextStyle(
                    color: textColor ?? Colors.black,
                    fontSize: Constants.tableFontSize)
                : TextStyle(
                    color: Colors.blue,
                    decoration: TextDecoration.underline,
                    fontSize: Constants.tableFontSize),
            textAlign: textAlign),
      ),
    ),
  );
}

String cleanseString(String input) {
  if (input == null || input.isEmpty) return input;
  String output = input.replaceAll("\\r", "");
  output = input.replaceAll("\\n", "");
  output = input.replaceAll("\\t", "");
  return output;
}

String getFirstName(String name) {
  if (name == null || name.isEmpty) return name;
  try {
    return name.split(" ")[0];
  } catch (ex) {
    return name;
  }
}

String capitalize(String input) {
  if (input == null || input.isEmpty) return input;
  try {
    return input[0].toUpperCase() + input.substring(1, input.length);
  } catch (ex) {
    return input;
  }
}

String formatNumber(num input) {
  if (input == null) return "-";
  final n = num.parse(input.toStringAsFixed(2));
  final formatCurrency = new NumberFormat.decimalPattern("id_ID");
  try {
    return formatCurrency.format(n);
  } catch (ex) {
    return input.toString();
  }
}

double parseDouble(String input) {
  try {
    return double.parse(input);
  } catch (ex) {
    return 0;
  }
}

int parseInt(String input) {
  try {
    return int.parse(input);
  } catch (ex) {
    return 0;
  }
}

String parseStringForChart(String input) {
  try {
    return input.replaceAll(" ", "\n");
  } catch (ex) {
    return input;
  }
}

TableCell emptyCell() {
  return TableCell(
    child: Container(),
  );
}

Map<String, List<T>> sortBasedOnKey<T>(Map<String, List<T>> input) {
  Map<String, List<T>> output = {};
  List<String> sortedKeys = input.keys.toList()
    ..sort((a, b) => int.parse(a).compareTo(int.parse(b)));
  sortedKeys.forEach((key) => output[key] = input[key]);
  return output;
}

Map<int, List<T>> sortBasedOnIntKey<T>(Map<int, List<T>> input) {
  Map<int, List<T>> output = {};
  List<int> sortedKeys = input.keys.toList()..sort((a, b) => a.compareTo(b));
  sortedKeys.forEach((key) => output[key] = input[key]);
  return output;
}

Map<String, int> sortBasedOnValueNew(Map<String, int> input) {
  Map<String, int> output = {};
  List<String> sortedKeys = input.keys.toList()
    ..sort((a, b) {
      try {
        return input[b].compareTo(input[a]);
      } catch (ex) {
        return 0;
      }
    });
  sortedKeys.forEach((key) => output[key] = input[key]);
  return output;
}

// Extension functions on NavigatorState
extension MapExtension<T extends Sortable> on Map<String, T> {
  Map<String, T> sortBasedOnValue({bool absValue = true}) {
    Map<String, T> output = {};
    List<String> sortedKeys = this.keys.toList()
      ..sort((a, b) {
        try {
          num bNum = this[b].getNumber();
          if (absValue) bNum = bNum.abs();
          num aNum = this[a].getNumber();
          if (absValue) aNum = aNum.abs();
          return bNum.compareTo(aNum);
        } catch (ex) {
          return 0;
        }
      });
    sortedKeys.forEach((key) => output[key] = this[key]);
    return output;
  }
}

extension MapExtensionDouble on Map<String, double> {
  Map<String, double> sortBasedOnValue({bool absValue = true}) {
    Map<String, double> output = {};
    List<String> sortedKeys = this.keys.toList()
      ..sort((a, b) {
        try {
          num bNum = this[b];
          if (absValue) bNum = bNum.abs();
          num aNum = this[a];
          if (absValue) aNum = aNum.abs();
          return bNum.compareTo(aNum);
        } catch (ex) {
          return 0;
        }
      });
    sortedKeys.forEach((key) => output[key] = this[key]);
    return output;
  }
}

// Extension functions on NavigatorState
extension PenyebaranMapExtension<T extends PenyebaranWilayahDataType>
    on Map<String, T> {
  Map<String, T> sortBasedOnValue({bool absValue = true}) {
    Map<String, T> output = {};
    List<String> sortedKeys = this.keys.toList()
      ..sort((a, b) {
        try {
          num bNum = this[b].getTotal();
          if (absValue) bNum = bNum.abs();
          num aNum = this[a].getTotal();
          if (absValue) aNum = aNum.abs();
          return bNum.compareTo(aNum);
        } catch (ex) {
          return 0;
        }
      });
    sortedKeys.forEach((key) => output[key] = this[key]);
    return output;
  }
}

// Extension functions on NavigatorState
extension MapListExtension<T> on Map<String, List<T>> {
  Map<String, List<T>> sortBasedOnCount() {
    Map<String, List<T>> output = {};
    List<String> sortedKeys = this.keys.toList()
      ..sort((a, b) {
        try {
          return this[b].length.compareTo(this[a].length);
        } catch (ex) {
          return 0;
        }
      });
    sortedKeys.forEach((key) => output[key] = this[key]);
    return output;
  }
}

// need to know how to get rid of this shitty hardcode, prolly ask backend to change
Map<String, List<GrafikLabaRugiDetailed>> mapLabaRugiToList(
    Map<String, GrafikLabaRugi> input) {
  return input.map<String, List<GrafikLabaRugiDetailed>>((k, v) => MapEntry(k, [
        GrafikLabaRugiDetailed(
            jenis: "Laba", tahun: v.tahun, akun: "Laba", jumlah: v.laba),
        GrafikLabaRugiDetailed(
            jenis: "Laba Bersih",
            tahun: v.tahun,
            akun: "Laba Bersih",
            jumlah: v.labaBersih),
        GrafikLabaRugiDetailed(
            jenis: "Rugi (Negatif)",
            tahun: v.tahun,
            akun: "Rugi",
            jumlah: v.rugi),
      ]));
}

// Extension functions on NavigatorState
extension StoreExtension<T> on Store<AppState> {
  String getNamaPendek(String companyName) {
    try {
      return this
          .state
          .companiesState
          .companies
          .firstWhere((a) => a.nama == companyName)
          .namaPendek;
    } catch (ex) {
      return companyName;
    }
  }

  String getNamaPendekById(String companyId) {
    try {
      final company = this
          .state
          .companiesState
          .companies
          .firstWhere((a) => a.id == companyId);
      return company.namaPendek ?? company.nama;
    } catch (ex) {
      return "-";
    }
  }

  List<String> getClusterList() {
    try {
      final List<String> clusterList = [];
      final companies = this.state.companiesState.companies;
      companies.forEach((a) {
        if (a.cluster != "-" && !clusterList.contains(a.cluster))
          clusterList.add(a.cluster);
      });
      return clusterList;
    } catch (ex) {
      return [];
    }
  }
}

String convertKelasToString(int kelas) {
  return "Kelas $kelas";
}

int convertStringToKelas(String kelas) {
  try {
    final arr = kelas.split(" ");
    return int.parse(arr[arr.length - 1]);
  } catch (ex) {
    return 1;
  }
}

double getInterval(num input) {
  print('input $input');
  if (input <= 0) return 0;
  double interval = 1;
  while (input / interval > 1) {
    interval = interval * 10;
  }
  if (input / interval < 1) {
    interval = interval / 10;
  }
  return interval;
}

mixin Searchable {
  String getKey();
}

extension ListExtension<T extends Searchable> on List<T> {
  T firstWhereOrNull({@required String key}) {
    try {
      return this.firstWhere((element) => element.getKey() == key);
    } catch (ex) {
      return null;
    }
  }
}

Widget summaryItem(
    {double height,
    @required String key,
    @required int count,
    Color color = Colors.white,
    Color textColor,
    bool isCentered = false,
    String extraData,
    double contentTextSize = 17.0}) {
  String text = "${formatNumber(count)} Orang";
  if (extraData != null) text += extraData;

  return Container(
    height: height,
    child: Card(
      elevation: 4,
      color: color,
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment:
              isCentered ? CrossAxisAlignment.center : CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              key,
              style: TextStyle(
                color: textColor != null
                    ? textColor
                    : color == Colors.white
                        ? Colors.black
                        : Colors.white,
                fontSize: 14.0,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: Text(
                text,
                style: TextStyle(
                    color: textColor != null
                        ? textColor
                        : color == Colors.white
                            ? Colors.black
                            : Colors.white,
                    fontSize: contentTextSize,
                    fontWeight: FontWeight.w700),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

void launchUrl(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

DateTime parseDateTime(String datetime) {
  try {
    final formatter = DateFormat("yyyy-MM-dd");
    return formatter.parse(datetime);
  } catch (ex) {
    return DateTime(2020, 1, 1);
  }
}

String dateTimeToString(DateTime datetime) {
  try {
    initializeDateFormatting('id', null);
    var newFormat = new DateFormat.yMMMMd('id');
    String formattedDate = newFormat.format(datetime);
    return formattedDate;
  } catch (ex) {
    print(ex.toString());
    return "-";
  }
}

Color getColorFromSum(num jumlah) {
  if (jumlah >= 100) return Colors.green;
  if (jumlah >= 80) return Color(0xFF0D8B005);
  return Colors.redAccent;
}
