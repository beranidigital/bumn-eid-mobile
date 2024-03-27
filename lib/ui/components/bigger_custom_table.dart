import 'package:bumn_eid/core/utils/constants.dart';
import 'package:bumn_eid/ui/utils/color_palette.dart';
import 'package:bumn_eid/ui/utils/widget_utils.dart';
import 'package:flutter/material.dart';

abstract class BiggerCustomTableData {
  String getTahun();

  num getJumlah();
}

class BiggerCustomTable<T extends BiggerCustomTableData>
    extends StatelessWidget {
  final ColorPalette colorPalette;
  final Map<String, List<T>> data;
  final Color color;
  final String title;
  final double firstColumnWidth;
  final double fontSize;

  BiggerCustomTable({
    @required this.colorPalette,
    @required this.data,
    @required this.color,
    @required this.title,
    this.firstColumnWidth = 120,
    this.fontSize = 15.0,
  });

  Widget topCell(BuildContext context, String text, Color color) {
    return TableCell(
      verticalAlignment: TableCellVerticalAlignment.middle,
      child: text == null
          ? Container()
          : Container(
              margin:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: tableText(
                    text: text,
                    textStyle: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: colorPalette.darkGrey,
                      fontSize: 15.0,
                    ),
                  ),
                ),
              ),
            ),
    );
  }

  Widget customizedCell({
    @required String text,
    @required BuildContext context,
    String tahun,
    TextStyle textStyle,
    VoidCallback onTap,
    TextAlign textAlign,
    Color color,
  }) {
    return TableCell(
      verticalAlignment: TableCellVerticalAlignment.middle,
      child: GestureDetector(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
          child: tableText(
              text: text,
              textAlign: textAlign ?? TextAlign.center,
              textStyle: textStyle ??
                  TextStyle(
                    color: colorPalette.primary,
                    fontSize: fontSize == 15.0
                        ? (isSmallDevice(context) ? 13.0 : 15.0)
                        : fontSize,
                    fontWeight: tahun == Constants.latestDataYear
                        ? FontWeight.w700
                        : FontWeight.w400,
                  )),
        ),
      ),
    );
  }

  Widget customTable(
      {BuildContext context,
      BoxDecoration decoration,
      List<TableRow> headerRow,
      List<TableRow> rows}) {
    if (headerRow.first.children.length < 4) {
      headerRow.first.children.add(topCell(context, "-", color));
    }
    return Container(
      alignment: Alignment.center,
      decoration: decoration,
      child: Table(
        columnWidths: {
          0: FixedColumnWidth(firstColumnWidth),
          1: FlexColumnWidth(100),
          2: FlexColumnWidth(100),
          3: FlexColumnWidth(100),
        },
        children: []..addAll(headerRow)..addAll(rows),
      ),
    );
  }

  Widget trilliun(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Color(0xFFFFFCF5),
        border: Border.all(
            color: colorPalette.infoBg, width: 1, style: BorderStyle.solid),
        borderRadius: BorderRadius.circular(4.0),
      ),
      margin: EdgeInsets.symmetric(vertical: 4.0),
      padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Icon(
              Icons.info_outline,
              color: colorPalette.darkGrey,
            ),
          ),
          Text(
            "Data ditampilkan dalam triliun rupiah",
            style: TextStyle(
              fontSize: isSmallDevice(context) ? 12.0 : 14.0,
              color: colorPalette.darkGrey,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        trilliun(context),
        customTable(
          decoration: BoxDecoration(
            color: Colors.transparent,
          ),
          headerRow: [
            TableRow(
              children: [topCell(context, null, color)]
                ..addAll(List.generate(data[data.keys.first].length, (idx) {
                  return topCell(
                      context, data[data.keys.first][idx].getTahun(), color);
                })),
            ),
          ],
          rows: List.generate(data.keys.toList().length, (idx) {
            final key = data.keys.toList()[idx];
            final datum = data[key];
            final row = TableRow(
                decoration: BoxDecoration(
                  color: colorPalette.white,
                  borderRadius: BorderRadius.circular(4.0),
                ),
                children: [
                  customizedCell(
                      text: capitalize(
                          key == "operasi" ? "Cashflow Operasi" : key),
                      textAlign: TextAlign.start,
                      textStyle: TextStyle(
                          color: colorPalette.black,
                          fontSize: 16.0,
                          fontWeight: FontWeight.w600),
                      context: context),
                ]..addAll((List.generate(datum.length, (index) {
                    final jumlah = datum[index].getJumlah();
                    String jumlahString;
                    if (jumlah == null) {
                      jumlahString = "-";
                    } else {
                      jumlahString = formatNumber((jumlah / 1000000));
                    }
                    return customizedCell(
                        context: context,
                        text: jumlahString,
                        tahun: datum[index].getTahun(),
                        textAlign: TextAlign.end,
                        color: color);
                  }))));
            if (row.children.length < 4) {
              row.children
                ..addAll(List.generate(4 - row.children.length, (idx) {
                  return customizedCell(
                    context: context,
                    text: "-",
                    color: color,
                  );
                }));
            }
            return row;
          }),
        ),
      ],
    );
  }
}
