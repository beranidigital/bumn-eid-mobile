import 'package:bumn_eid/ui/utils/widget_utils.dart';
import 'package:flutter/material.dart';

class HorizontalBarChart extends StatelessWidget {
  final Map<String, int> data;
  final int customTotal;

  HorizontalBarChart({
    @required this.data,
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
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: finalData.keys.map(
        (e) {
          final datum = finalData[e];
          final percentage = (datum / total);
          final percentage100 = (percentage * 100).truncateToDouble();
          return Padding(
            padding: const EdgeInsets.only(
              bottom: 8.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: LayoutBuilder(
                    builder: (ctx, constraints) {
                      return Container(
                        height: 16.0,
                        width: constraints.maxWidth,
                        child: Stack(
                          children: [
                            Container(
                              height: 16.0,
                              width: constraints.maxWidth * percentage,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4.0),
                                color: Color(0xFF00BDCC),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8.0,
                              ),
                              child: Text(
                                e ?? '-',
                                style: TextStyle(
                                  fontSize: 12.0,
                                  fontFamily: 'lato',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(
                  width: 8.0,
                ),
                Text(
                  '$datum ($percentage100 %)',
                  style: TextStyle(
                    fontFamily: 'lato',
                    fontWeight: FontWeight.w400,
                    fontSize: 12.0,
                  ),
                ),
              ],
            ),
          );
        },
      ).toList(),
    );
  }
}
