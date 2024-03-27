import 'package:bumn_eid/ui/utils/widget_utils.dart';
import 'package:flutter/material.dart';

class VerticalBarChart extends StatelessWidget {
  final Map<String, int> data;
  final double height;
  final int customTotal;

  VerticalBarChart({
    @required this.data,
    @required this.height,
    this.customTotal,
  });

  @override
  Widget build(BuildContext context) {
    Map<String, int> finalData = {};
    if (data.keys.length > 5) {
      Map<String, int> z = sortBasedOnValueNew(data);
      int counter = 0;
      z.keys.forEach((element) {
        if (counter <= 5) {
          finalData[element] = z[element];
        }
        counter++;
      });
    } else {
      finalData = data;
    }

    final total = customTotal ?? data.values.fold(0, (a, b) => a + b);
    return Container(
      height: height,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: finalData.keys.map(
          (e) {
            int datum;
            try {
              datum = finalData[e];
            } catch (ex) {
              datum = 0;
            }
            final percentage = (datum / total);
            final percentage100 = (percentage * 100).truncateToDouble();
            return Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: 4.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      datum.toString(),
                      style: TextStyle(
                        fontFamily: 'lato',
                        fontWeight: FontWeight.w500,
                        fontSize: 11.0,
                      ),
                    ),
                    Text(
                      ' ${percentage100.toString()} %',
                      style: TextStyle(
                        fontFamily: 'lato',
                        fontWeight: FontWeight.w500,
                        fontSize: 11.0,
                      ),
                    ),
                    SizedBox(
                      height: 2.0,
                    ),
                    Expanded(
                      child: Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          LayoutBuilder(
                            builder: (ctx, constraints) {
                              return Container(
                                width: double.infinity,
                                height: constraints.maxHeight * percentage,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4.0),
                                  color: Color(0xFF00BDCC),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    Text(
                      e,
                      style: TextStyle(
                        fontFamily: 'lato',
                        fontWeight: FontWeight.w400,
                        fontSize: 12.0,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            );
          },
        ).toList(),
      ),
    );
  }
}
