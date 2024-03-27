import 'package:bumn_eid/core/controllers/jenis_controller.dart';
import 'package:bumn_eid/core/models/business_portfolio/general_company.dart';
import 'package:bumn_eid/core/redux/states/app_state/app_state.dart';
import 'package:bumn_eid/ui/components/custom_pie_chart.dart';
import 'package:bumn_eid/ui/components/loadable_widget.dart';
import 'package:bumn_eid/ui/utils/color_palette.dart';
import 'package:bumn_eid/ui/utils/widget_utils.dart';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';

class BumnByClassWidget extends StatefulWidget {
  final JenisController jenisController;
  final Store<AppState> store;

  BumnByClassWidget({
    @required this.jenisController,
    @required this.store,
  });

  @override
  _BumnByClassWidgetState createState() => _BumnByClassWidgetState();
}

class _BumnByClassWidgetState extends State<BumnByClassWidget> {
  int tahun = 2020;

  @override
  Widget build(BuildContext context) {
    return LoadableWidget<Map<String, List<GeneralCompany>>>(
      fetchFunction: () async {
        Map<String, List<GeneralCompany>> categorizedCompanies = {};

        final data = widget.store.state.companiesState.companies;
        data.forEach((company) {
          final kelas = convertKelasToString(parseInt(company.getKelas()));
          if (!categorizedCompanies.containsKey(kelas)) {
            categorizedCompanies[kelas] = [company];
          } else {
            categorizedCompanies[kelas] = categorizedCompanies[kelas]
              ..add(company);
          }
        });

        return Future.value(categorizedCompanies);
      },
      colorPalette: ColorPalette(),
      buildFunction: (context, dynamic generalData) {
        Map<String, List<GeneralCompany>> finalData = generalData;

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
                'BUMN By Kelas',
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
                tableData: finalData,
                colorPalette: ColorPalette(),
              ),
            ],
          ),
        );
      },
    );
  }
}
