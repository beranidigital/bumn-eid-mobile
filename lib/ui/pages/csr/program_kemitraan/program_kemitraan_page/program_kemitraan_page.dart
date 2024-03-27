import 'package:bumn_eid/core/di/injectable_widget.dart';
import 'package:bumn_eid/core/strings/strings.dart';
import 'package:bumn_eid/irwan_dev/services/api_statistic.dart';
import 'package:bumn_eid/ui/components/base_scaffold.dart';
import 'package:bumn_eid/ui/components/main_menu.dart';
import 'package:bumn_eid/ui/pages/csr/program_kemitraan/program_kemitraan_page/di/program_kemitraan_page_graph.dart';
import 'package:bumn_eid/ui/pages/csr/program_kemitraan/program_kemitraan_page/program_kemitraan_action_mapper.dart';
import 'package:bumn_eid/ui/utils/color_palette.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ProgramKemitraanPage extends StatefulWidget with InjectableWidget {
  final ProgramKemitraanPageGraph _graph;

  //injected
  ColorPalette colorPalette;
  //injected
  ProgramKemitraanActionMapper actionMapper;

  @override
  ProgramKemitraanPageGraph graph() => _graph;

  ProgramKemitraanPage([graph])
      : this._graph = graph ?? ProgramKemitraanPageGraph() {
    setup();
  }

  @override
  _ProgramKemitraanPageState createState() => _ProgramKemitraanPageState();
}

class _ProgramKemitraanPageState extends State<ProgramKemitraanPage> {
  Widget menuList(BuildContext context) {
    return Container(
      color: Color(0xFFEEEFF3),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 8.0,
          horizontal: 16.0,
        ),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 16.0,
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: MainMenu(
                      imagePath: "res/images/realisasi.png",
                      colorPalette: widget.colorPalette,
                      title: "Realisasi Dana",
                      onTap: () {
                        ApiStatistic().insertStatistic(
                            "CSR", "Level 3 Realisasi Dana Program Kemitraan");
                        widget.actionMapper.openRealisasiDana();
                      },
                    ),
                  ),
                  SizedBox(
                    width: 16.0,
                  ),
                  Expanded(
                    child: MainMenu(
                      imagePath: "res/images/sektor_penyaluran.png",
                      colorPalette: widget.colorPalette,
                      title: "Sektor Penyaluran",
                      onTap: () {
                        ApiStatistic().insertStatistic("CSR",
                            "Level 3 Sektor Penyaluran Program Kemitraan");
                        widget.actionMapper.openSektorPenyaluran();
                      },
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 16.0,
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: MainMenu(
                      imagePath: "res/images/penyebaran.png",
                      colorPalette: widget.colorPalette,
                      title: "Penyebaran Wilayah",
                      onTap: () {
                        ApiStatistic().insertStatistic("CSR",
                            "Level 3 Penyebaran Wilayah Program Kemitraan");
                        widget.actionMapper.openPenyebaranWilayah();
                      },
                    ),
                  ),
                  SizedBox(
                    width: 16.0,
                  ),
                  Expanded(
                    child: MainMenu(
                      imagePath: "res/images/mitra_binaan.png",
                      colorPalette: widget.colorPalette,
                      title: "Jumlah Mitra Binaan",
                      onTap: () {
                        ApiStatistic().insertStatistic("CSR",
                            "Level 3 Jumlah Mitra Binaan Program Kemitraan");
                        widget.actionMapper.openMitraBinaan();
                      },
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 16.0,
            ),
            Expanded(
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: MainMenu(
                      imagePath: "res/images/profile.png",
                      colorPalette: widget.colorPalette,
                      title: "PK By Company",
                      onTap: () {
                        ApiStatistic().insertStatistic(
                            "CSR", "Level 3 PK By Company Program Kemitraan");
                        widget.actionMapper.openPkByCompany();
                      },
                    ),
                  ),
                  SizedBox(
                    width: 16.0,
                  ),
                  Expanded(
                    child: Container(
                      color: Colors.transparent,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 8.0,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      title: Strings.getString("ProgramKemitraanPage.Title"),
      body: (ctx) => SafeArea(
        child: menuList(context),
      ),
    );
  }
}
