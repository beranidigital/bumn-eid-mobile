import 'package:bumn_eid/ui/utils/widget_utils.dart';
import 'package:flutter/material.dart';

class HcSummaryMenu extends StatelessWidget {

  final String title;
  final int total;
  final String imagePath;
  final Color bgColor;
  final Color bgColorBottom;
  final VoidCallback onTap;
  final VoidCallback onTapToCompany;
  final int totalAnak;
  final int totalCucu;
  final double textSize;

  HcSummaryMenu({
    @required
    this.title,
    @required
    this.total,
    @required
    this.imagePath,
    @required
    this.bgColor,
    @required
    this.bgColorBottom,
    @required
    this.onTap,
    this.onTapToCompany,
    this.textSize = 14,
    this.totalAnak = 0,
    this.totalCucu = 0,
  });

  Widget textContent({
    @required
    BuildContext context,
    @required
    String title,
    @required
    int count
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Expanded(
          child: Text(
            title,
            style: TextStyle(
              fontSize: textSize,
              fontWeight: FontWeight.w700
            ),
          ),
        ),
        Text(
          count > 0 ? formatNumber(count) : "-",
          style: TextStyle(
            fontSize: textSize,
            fontWeight: FontWeight.w600
          ),
        ),
        Icon(
          Icons.person,
          size: textSize,
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: bgColorBottom,
          borderRadius: BorderRadius.circular(4.0),
          boxShadow: [
            BoxShadow(
                color: Colors.black26,
                offset: Offset(1.0, 2.0)
            )
          ]
      ),
      margin: EdgeInsets.symmetric(horizontal: 8.0,vertical: 8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          GestureDetector(
            onTap: onTap,
            child: Container(
              decoration: BoxDecoration(
                  color: bgColor,
                  borderRadius: BorderRadius.circular(4.0),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Container(
                            child: Image(
                              image: AssetImage(imagePath),
                              height: 24,
                              width: 24,
                            ),
                          ),
                        ),
                        Container(
                          width: 2,
                          color: Colors.black26,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(
                        title,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: GestureDetector(
                        onTap: onTap,
                        child: textContent(context: context, title: "Induk", count: total)),
                  ),
                  Expanded(
                    child: GestureDetector(
                        onTap: onTapToCompany ?? onTap,
                        child: textContent(context: context, title: "Anak Perusahaan", count: totalAnak)),
                  ),
                  Expanded(
                    child: GestureDetector(
                        onTap: onTapToCompany ?? onTap,
                        child: textContent(context: context, title: "Cucu Perusahaan", count: totalCucu)),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
