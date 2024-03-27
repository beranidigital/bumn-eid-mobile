import 'package:bumn_eid/ui/utils/color_palette.dart';
import 'package:flutter/material.dart';

class CustomExpansionTile extends StatefulWidget {
  final ColorPalette colorPalette;
  final List<Widget> children;
  final String text;
  final IconData icon;
  final Widget iconWidget;
  final EdgeInsets padding;
  final Widget trailingWidget;
  final Color color;
  final Color textColor;

  CustomExpansionTile({
    @required this.colorPalette,
    @required this.children,
    @required this.text,
    this.icon,
    this.iconWidget,
    this.padding = EdgeInsets.zero,
    this.trailingWidget,
    this.color = Colors.white,
    this.textColor = Colors.black,
  });

  @override
  _CustomExpansionTileState createState() => _CustomExpansionTileState();
}

class _CustomExpansionTileState extends State<CustomExpansionTile> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: widget.color,
        borderRadius: BorderRadius.circular(4.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 0.0,
            blurRadius: 4,
            offset: Offset(0, 5), // changes position of shadow
          ),
        ],
      ),
      child: ExpansionTile(
        backgroundColor: widget.color,
        title: Container(),
        leading: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            widget.iconWidget ?? Container(),
            widget.iconWidget == null
                ? Container()
                : SizedBox(
                    width: 8.0,
                  ),
            Text(
              widget.text,
              style: TextStyle(
                fontSize: 14.0,
                color: widget.textColor,
                fontFamily: 'poppins',
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        onExpansionChanged: (newState) {
          setState(() {
            this.isExpanded = newState;
          });
        },
        trailing: widget.trailingWidget ??
            Icon(
              isExpanded ? Icons.arrow_drop_down : Icons.arrow_drop_up,
              color: widget.colorPalette.black,
            ),
        children: <Widget>[
          Container(
            color: widget.colorPalette.white,
            width: MediaQuery.of(context).size.width,
            padding: widget.padding,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: widget.children,
            ),
          )
        ],
      ),
    );
  }
}
