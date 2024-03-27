import 'package:bumn_eid/core/controllers/jenis_controller.dart';
import 'package:bumn_eid/core/models/business_portfolio/grafik_jenis_perusahaan.dart';
import 'package:bumn_eid/ui/components/custom_pie_chart.dart';
import 'package:bumn_eid/ui/components/loadable_widget.dart';
import 'package:bumn_eid/ui/utils/color_palette.dart';
import 'package:flutter/material.dart';

class BumnByOwnershipWidget extends StatefulWidget {
  final JenisController jenisController;

  BumnByOwnershipWidget({
    @required this.jenisController,
  });

  @override
  _BumnByOwnershipWidgetState createState() => _BumnByOwnershipWidgetState();
}

class _BumnByOwnershipWidgetState extends State<BumnByOwnershipWidget> {
  int tahun = 2020;

  @override
  Widget build(BuildContext context) {
    return LoadableWidget<Map<String, List<GrafikJenisPerusahaan>>>(
      fetchFunction: () async {
        final data = await widget.jenisController.fetchGrafikJenis();
        Map<String, List<GrafikJenisPerusahaan>> chartData = {};
        data.forEach((grafikData) {
          if (chartData.containsKey(grafikData.tahun)) {
            chartData[grafikData.tahun].add(grafikData);
          } else {
            chartData[grafikData.tahun] = [grafikData];
          }
        });

        chartData.values.forEach((list) {
          list.sort((GrafikJenisPerusahaan a, GrafikJenisPerusahaan b) =>
              a.jenis_bumn.compareTo(b.jenis_bumn));
        });

        return chartData;
      },
      colorPalette: ColorPalette(),
      buildFunction: (context, dynamic generalData) {
        Map<String, List<GrafikJenisPerusahaan>> data = generalData;
        final yearData = data[tahun.toString()];
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
                'BUMN By Ownership',
                style: TextStyle(
                  fontFamily: 'poppins',
                  fontWeight: FontWeight.w600,
                  fontSize: 12.0,
                ),
              ),
              SizedBox(
                height: 16.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      setState(() {
                        tahun = 2020;
                      });
                    },
                    child: Text(
                      '2020',
                      style: TextStyle(
                        fontFamily: 'lato',
                        fontWeight: FontWeight.w700,
                        fontSize: 12.0,
                        color: tahun == 2020 ? Color(0xFF6678DB) : Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 8.0,
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        tahun = 2019;
                      });
                    },
                    child: Text(
                      '2019',
                      style: TextStyle(
                        fontFamily: 'lato',
                        fontWeight: FontWeight.w700,
                        fontSize: 12.0,
                        color: tahun == 2019 ? Color(0xFF6678DB) : Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 8.0,
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        tahun = 2018;
                      });
                    },
                    child: Text(
                      '2018',
                      style: TextStyle(
                        fontFamily: 'lato',
                        fontWeight: FontWeight.w700,
                        fontSize: 12.0,
                        color: tahun == 2018 ? Color(0xFF6678DB) : Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 8.0,
              ),
              CustomPieChart(
                tableData: yearData.asMap().map(
                      (key, value) => MapEntry(value.jenis_bumn, [value]),
                    ),
                customTotalCount: yearData.fold(0, (a, b) => a + b.jumlah),
                customCountFunction: (List<dynamic> x) => x.first.jumlah,
                colorPalette: ColorPalette(),
              ),
            ],
          ),
        );
      },
    );
  }
}
