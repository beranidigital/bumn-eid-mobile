import 'package:bumn_eid/core/models/legal/legal_summary_data.dart';
import 'package:bumn_eid/ui/components/horizontal_bar_chart.dart';
import 'package:flutter/material.dart';

class LegalBUMN extends StatefulWidget {
  final LegalSummaryData data;

  LegalBUMN({
    @required this.data,
  });

  @override
  _LegalBUMNState createState() => _LegalBUMNState();
}

class _LegalBUMNState extends State<LegalBUMN> {
  @override
  Widget build(BuildContext context) {
    Map<String, int> data = {};
    final sortedData = widget.data.summary_bumn;
    sortedData.sort((a, b) => b.total_perkara - a.total_perkara);
    sortedData.forEach((element) {
      if (element.bumn != null && data.keys.length <= 5) {
        data[element.bumn] = element.total_perkara;
      }
    });

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(
          color: Color(0xFF1FA4CA),
          width: 2.0,
        ),
      ),
      padding: EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'TOP 5 BUMN Terlibat',
            style: TextStyle(
              fontFamily: 'poppins',
              fontWeight: FontWeight.w600,
              fontSize: 12.0,
            ),
          ),
          SizedBox(
            height: 16.0,
          ),
          HorizontalBarChart(
            data: data,
            customTotal: widget.data.legalSummaryAll.melibatkan_bumn,
          ),
        ],
      ),
    );
  }
}
