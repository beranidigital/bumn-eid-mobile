import 'package:bumn_eid/core/di/injectable_widget.dart';
import 'package:bumn_eid/irwan_dev/services/api_statistic.dart';
import 'package:bumn_eid/ui/components/base_scaffold.dart';
import 'package:bumn_eid/ui/components/main_menu.dart';
import 'package:bumn_eid/ui/pages/csr/bina_lingkungan/bina_lingkungan_page/bina_lingkungan_action_mapper.dart';
import 'package:bumn_eid/ui/pages/csr/bina_lingkungan/bina_lingkungan_page/di/bina_lingkungan_page_graph.dart';
import 'package:bumn_eid/ui/utils/color_palette.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class BinaLingkunganPage extends StatefulWidget with InjectableWidget {
  final BinaLingkunganPageGraph _graph;

  //injected
  ColorPalette colorPalette;
  //injected
  BinaLingkunganActionMapper actionMapper;

  @override
  BinaLingkunganPageGraph graph() => _graph;

  BinaLingkunganPage([graph])
      : this._graph = graph ?? BinaLingkunganPageGraph() {
    setup();
  }

  @override
  _BinaLingkunganPageState createState() => _BinaLingkunganPageState();
}

class _BinaLingkunganPageState extends State<BinaLingkunganPage> {
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
              height: 8.0,
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
                            "CSR", "Level 3 Realisasi Dana Bina Lingkungan");
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
                      title: "Jenis Bantuan",
                      onTap: () {
                        ApiStatistic().insertStatistic(
                            "CSR", "Level 3 Jenis Bantuan Bina Lingkungan");
                        widget.actionMapper.openJenisPenyebaran();
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
                            "Level 3 Penyebaran Wilayah Bina Lingkungan");
                        widget.actionMapper.openPenyebaranWilayah();
                      },
                    ),
                  ),
                  SizedBox(
                    width: 16.0,
                  ),
                  Expanded(
                    child: MainMenu(
                      imagePath: "res/images/profile.png",
                      colorPalette: widget.colorPalette,
                      title: "BL By Company",
                      onTap: () {
                        ApiStatistic().insertStatistic(
                            "CSR", "Level 3 BL By Company Bina Lingkungan");
                        widget.actionMapper.openBlCompanies();
                      },
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      color: Colors.transparent,
                    ),
                  ),
                  Expanded(
                    child: Container(
                      color: Colors.transparent,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      title: 'Bina Lingkungan',
      body: (ct) => menuList(context),
    );
  }
}
