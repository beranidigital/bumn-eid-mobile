import 'package:bumn_eid/core/models/legal/legal_summary_data.dart';
import 'package:bumn_eid/ui/components/custom_pie_chart.dart';
import 'package:bumn_eid/ui/utils/color_palette.dart';
import 'package:flutter/material.dart';

class LegalJenis extends StatefulWidget {
  final LegalSummaryData data;

  LegalJenis({
    @required this.data,
  });

  @override
  _LegalJenisState createState() => _LegalJenisState();
}

class _LegalJenisState extends State<LegalJenis> {
  @override
  Widget build(BuildContext context) {
    Map<String, List<int>> jenisData = {};
    jenisData['Arbitrase'] = [widget.data.summary_jenis.arbitrase];
    jenisData['Judicial Review'] = [widget.data.summary_jenis.judicial_review];
    jenisData['Perdata'] = [widget.data.summary_jenis.Perdata];

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
            'Jenis Perkara',
            style: TextStyle(
              fontFamily: 'poppins',
              fontWeight: FontWeight.w600,
              fontSize: 12.0,
            ),
          ),
          SizedBox(
            height: 16.0,
          ),
          CustomPieChart(
            tableData: jenisData,
            customTotalCount: jenisData.values.fold(0, (a, b) => a + b.first),
            customCountFunction: (List<dynamic> x) => x.first,
            colorPalette: ColorPalette(),
          ),
        ],
      ),
    );
  }
}
