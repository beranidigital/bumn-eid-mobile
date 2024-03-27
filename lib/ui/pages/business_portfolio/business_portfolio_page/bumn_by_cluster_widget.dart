import 'package:bumn_eid/core/controllers/jenis_controller.dart';
import 'package:bumn_eid/core/models/business_portfolio/general_company.dart';
import 'package:bumn_eid/core/redux/states/app_state/app_state.dart';
import 'package:bumn_eid/ui/components/horizontal_bar_chart.dart';
import 'package:bumn_eid/ui/components/loadable_widget.dart';
import 'package:bumn_eid/ui/utils/color_palette.dart';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';

class BumnByClusterWidget extends StatefulWidget {
  final JenisController jenisController;
  final Store<AppState> store;

  BumnByClusterWidget({
    @required this.jenisController,
    @required this.store,
  });

  @override
  _BumnByClusterWidgetState createState() => _BumnByClusterWidgetState();
}

class _BumnByClusterWidgetState extends State<BumnByClusterWidget> {
  int tahun = 2020;

  @override
  Widget build(BuildContext context) {
    return LoadableWidget<Map<String, List<GeneralCompany>>>(
      fetchFunction: () async {
        Map<String, List<GeneralCompany>> categorizedCompanies = {};

        final data = widget.store.state.companiesState.companies;
        data.forEach((company) {
          final cluster = company.getCluster();
          if (!categorizedCompanies.containsKey(cluster)) {
            categorizedCompanies[cluster] = [company];
          } else {
            categorizedCompanies[cluster] = categorizedCompanies[cluster]
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
                'BUMN By Cluster',
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
                data:
                    finalData.map((key, value) => MapEntry(key, value.length)),
              ),
            ],
          ),
        );
      },
    );
  }
}
