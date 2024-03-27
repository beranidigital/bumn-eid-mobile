import 'package:bumn_eid/ui/components/sum_type_text.dart';
import 'package:bumn_eid/ui/utils/color_palette.dart';
import 'package:flutter/material.dart';

mixin SingleListItem {
  String getTitle();
}

class SingleListView<T extends SingleListItem> extends StatelessWidget {
  final ColorPalette colorPalette;
  final List<T> items;
  final Function(T) onItemTap;
  final Widget Function(T) leadingWidget;
  final Widget Function(T) extraBottomWidget;
  final num total;
  final String totalText;
  final bool totalPercentage;

  SingleListView({
    @required this.items,
    @required this.onItemTap,
    @required this.colorPalette,
    this.leadingWidget,
    this.extraBottomWidget,
    this.total,
    this.totalText = "Total",
    this.totalPercentage = false,
  });

  Widget itemTemplate({
    String idx,
    String title,
    Widget leadingWidget,
    bool withArrow = true,
    T item,
  }) {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: 6,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 16,
      ),
      decoration: BoxDecoration(
        color: colorPalette.white,
        borderRadius: BorderRadius.circular(
          8.0,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 0.0,
            blurRadius: 4,
            offset: Offset(0, 5), // changes position of shadow
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  width: 8.0,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Text(
                    idx == null ? "" : "$idx.",
                    style: TextStyle(
                      color: colorPalette.black,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: colorPalette.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      this.extraBottomWidget == null
                          ? Container()
                          : this.extraBottomWidget(item)
                    ],
                  ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              leadingWidget,
              withArrow
                  ? Icon(
                      Icons.arrow_forward,
                      color: colorPalette.primary,
                      size: 18,
                    )
                  : Container(),
            ],
          )
        ],
      ),
    );
  }

  Widget itemWidget(int idx) {
    final idxString = (idx + 1).toString();
    final item = items[idx];
    return Material(
      child: InkWell(
        onTap: () => onItemTap(item),
        child: itemTemplate(
          idx: idxString,
          title: item.getTitle(),
          item: item,
          leadingWidget: this.leadingWidget == null
              ? Container()
              : this.leadingWidget(item),
        ),
      ),
    );
  }

  Widget totalWidget(num total) {
    if (total == null) return Container();
    return itemTemplate(
      title: totalText,
      leadingWidget: SumTypeText(
        colorPalette: colorPalette,
        sum: total,
        percentage: totalPercentage,
      ),
      withArrow: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: total == null ? items.length : items.length + 1,
      itemBuilder: (context, idx) =>
          idx == items.length ? totalWidget(total) : itemWidget(idx),
    );
  }
}
