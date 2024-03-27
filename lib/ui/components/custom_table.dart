import 'package:bumn_eid/core/utils/constants.dart';
import 'package:bumn_eid/ui/utils/color_palette.dart';
import 'package:bumn_eid/ui/utils/widget_utils.dart';
import 'package:flutter/material.dart';

enum TableTextType {
  TEXT,
  NUMBER
}

class TableText {

  final String text;
  final TableTextType type;
  final double flexColumnWidth;

  TableText({
      @required
      this.text,
      this.type = TableTextType.TEXT,
      this.flexColumnWidth = 40.0,
  });

}

class CustomTable<T> extends StatelessWidget {

  final Map<String, T> data;
  final List<TableText> headers;
  final ColorPalette colorPalette;
  final TableRow Function(String, T) rowDescriptor;
  final num total;
  final bool withShadow;
  final EdgeInsets margin;
  final bool showTriliun;
  final double width;

  CustomTable({
      @required
      this.data,
      @required
      this.headers,
      @required
      this.colorPalette,
      @required
      this.rowDescriptor,
      this.total,
      this.withShadow = true,
      this.margin = const EdgeInsets.symmetric(vertical: 16.0),
      this.showTriliun = true,
      this.width
  });

  Widget tableCell({
    @required
    String text,
    TextStyle textStyle,
    VoidCallback onTap,
    TextAlign textAlign
  }) {
    return TableCell(
      verticalAlignment: TableCellVerticalAlignment.middle,
      child: GestureDetector(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
          child: Text(
            text,
            textAlign: textAlign ?? TextAlign.start,
            style: textStyle ?? TextStyle(
                color: Colors.black
            ),
          ),
        ),
      ),
    );
  }

  TableRow headerRow(BuildContext context) {
    return TableRow(
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(
                    color: Colors.black,
                    width: 2.0
                )
            )
        ),
        children: [
          tableCell(
              text: "No",
              textAlign: TextAlign.start,
              textStyle: TextStyle(
                fontSize: Constants.tableFontSize,
                fontWeight: FontWeight.w700
              )
          )
        ]..addAll(List.generate(headers.length, (idx) {
          return tableCell(
              text: headers[idx].text,
              textAlign: headers[idx].type == TableTextType.NUMBER ? TextAlign.end : TextAlign.start,
              textStyle: TextStyle(
                  fontSize: Constants.tableFontSize,
                  fontWeight: FontWeight.w700
              )
          );
        }))
    );
  }

  List<TableRow> tableContent(BuildContext context,) {
    List<TableRow> ret = [];

    int no = 1;
    data.keys.forEach((key) {
      if (data[key] != null) {
        ret.add(
          TableRow(
            decoration: BoxDecoration(
              color: no % 2 == 0 ? Colors.white : Colors.transparent
            ),
            children: [
              cell(text: no.toString(),),
            ]..addAll(
              rowDescriptor(key, data[key]).children
            )
          )
        );
        no++;
      }
    });
    if (total != null) {
      ret.add(
        TableRow(
          children: [
            emptyCell(),
            cell(text: "Total",),
          ]..addAll(List.generate(headers.length-2, (idx) {
            return emptyCell();
          }))..add(
            cell(text: formatNumber(total), textAlign: TextAlign.end)
          )
        )
      );
    }

    return ret;
  }

  Widget tableWidget(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: !withShadow ? null : BoxDecoration(
          color: Color(0xFFE7F0FF),
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [
            BoxShadow(
                color: Colors.black26,
                offset: Offset(1.0, 2.0)
            )
          ]
      ),
      child: Table(
        border: TableBorder(
            horizontalInside: BorderSide(
                color: colorPalette.lightGrey,
                width: 2.0
            )
        ),
        columnWidths: {
          0: FixedColumnWidth(45)
        }..addEntries(
          List.generate(headers.length, (idx) => MapEntry(idx+1,
              FlexColumnWidth(headers[idx].flexColumnWidth == null ? 160/headers.length : headers[idx].flexColumnWidth)))
        ),
        children: [
          headerRow(context),
        ]..addAll(tableContent(context)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      margin: margin,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          showTriliun ? Text(
            "* Data dalam Triliun Rupiah.",
            style: TextStyle(
              fontSize: 16.0
            ),
          ) : Container(),
          Padding(
            padding: EdgeInsets.only(top: showTriliun ? 8.0 : 0.0),
            child: tableWidget(context),
          ),
        ],
      ),
    );
  }
}
