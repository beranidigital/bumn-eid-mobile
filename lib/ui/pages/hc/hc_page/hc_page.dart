import 'package:after_layout/after_layout.dart';
import 'package:bumn_eid/core/controllers/hc_controller.dart';
import 'package:bumn_eid/core/di/injectable_widget.dart';
import 'package:bumn_eid/core/models/hc/hc_summary.dart';
import 'package:bumn_eid/core/redux/states/app_state/app_state.dart';
import 'package:bumn_eid/ui/components/base_card.dart';
import 'package:bumn_eid/ui/components/base_scaffold.dart';
import 'package:bumn_eid/ui/components/custom_error_widget.dart';
import 'package:bumn_eid/ui/components/horizontal_bar_chart.dart';
import 'package:bumn_eid/ui/components/loading_widget.dart';
import 'package:bumn_eid/ui/pages/hc/hc_page/di/hc_page_graph.dart';
import 'package:bumn_eid/ui/pages/hc/hc_page/hc_page_action_mapper.dart';
import 'package:bumn_eid/ui/utils/color_palette.dart';
import 'package:bumn_eid/ui/utils/widget_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';

// ignore: must_be_immutable
class HcPage extends StatefulWidget with InjectableWidget {
  final HcPageGraph _graph;

  @override
  HcPageGraph graph() => _graph;

  HcPageActionMapper actionMapper;

  Store<AppState> store;

  ColorPalette colorPalette;

  HcController hcController;

  HcPage([graph]) : this._graph = graph ?? HcPageGraph() {
    setup();
  }

  @override
  _HcPageState createState() => _HcPageState();
}

class _HcPageState extends State<HcPage> with AfterLayoutMixin<HcPage> {
  HcSummary data;
  bool isError = false;

  bool isDataReady() {
    return data != null;
  }

  @override
  void afterFirstLayout(BuildContext context) {
    getData();
  }

  void getData() async {
    try {
      setState(() {
        this.data = null;
        this.isError = false;
      });
      final summary = await widget.hcController.fetchHcSummary();

      setState(() {
        this.data = summary;
      });
    } catch (ex) {
      print(ex);
      setState(() {
        this.isError = true;
      });
    }
  }

  Widget containerMenu(
      {String title,
      String count,
      Color bgColor,
      Widget child,
      VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            color: bgColor, borderRadius: BorderRadius.circular(4.0)),
        padding: EdgeInsets.all(16.0),
        margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              title,
              style: TextStyle(
                  color: widget.colorPalette.white,
                  fontSize: 17.0,
                  fontWeight: FontWeight.w500),
            ),
            Text(
              count,
              style: TextStyle(
                  color: widget.colorPalette.white,
                  fontSize: 14.0,
                  fontWeight: FontWeight.w300),
            ),
            Expanded(
              child: child ?? Container(),
            ),
          ],
        ),
      ),
    );
  }

  Widget insideMenu({int count, String name, VoidCallback onTap}) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
              color: widget.colorPalette.white.withOpacity(0.5),
              borderRadius: BorderRadius.circular(4.0)),
          margin: EdgeInsets.only(left: 4.0, right: 4.0, top: 8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Text(
                    formatNumber(count) ?? "-",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: widget.colorPalette.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 20.0),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Text(
                      name,
                      style: TextStyle(
                          color: widget.colorPalette.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 12.0),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String currentKey = 'dashboard';

  List<Widget> dashboard(
    BuildContext context,
  ) {
    return [
      SizedBox(
        height: 16.0,
      ),
      BaseCard(
        title: 'Perusahaan Induk',
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Total Karyawan: ${data.totalPegawai}',
              style: TextStyle(
                fontSize: 13.0,
              ),
            ),
            SizedBox(
              height: 16.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () => widget.actionMapper.openBod1(),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          border: Border.all(
                            color: Color(0xFF1FA4CA),
                            width: 1.0,
                          )),
                      padding: EdgeInsets.only(
                        left: 8.0,
                        right: 8.0,
                        top: 16.0,
                        bottom: 8.0,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            'res/images/ic_building.png',
                            height: 24.0,
                            color: Color(0xFF1FA4CA),
                          ),
                          SizedBox(
                            height: 8.0,
                          ),
                          Text(
                            'Perusahaan',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 13.0,
                            ),
                          ),
                          SizedBox(
                            height: 4.0,
                          ),
                          Text(
                            data.totalBumn.toString(),
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 13.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 8.0,
                ),
                Expanded(
                  child: InkWell(
                    onTap: () => widget.actionMapper.openDewanKomisaris(),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          border: Border.all(
                            color: Color(0xFF1FA4CA),
                            width: 1.0,
                          )),
                      padding: EdgeInsets.only(
                        left: 8.0,
                        right: 8.0,
                        top: 16.0,
                        bottom: 8.0,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            'res/images/ic_boc.png',
                            height: 24.0,
                            color: Color(0xFF1FA4CA),
                          ),
                          SizedBox(
                            height: 8.0,
                          ),
                          Text(
                            'BOC',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 13.0,
                            ),
                          ),
                          SizedBox(
                            height: 4.0,
                          ),
                          Text(
                            data.jumlahKomisaris.toString(),
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 13.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 8.0,
                ),
                Expanded(
                  child: InkWell(
                    onTap: () => widget.actionMapper.openBod(),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          border: Border.all(
                            color: Color(0xFF1FA4CA),
                            width: 1.0,
                          )),
                      padding: EdgeInsets.only(
                        left: 8.0,
                        right: 8.0,
                        top: 16.0,
                        bottom: 8.0,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            'res/images/ic_boc.png',
                            height: 24.0,
                            color: Color(0xFF1FA4CA),
                          ),
                          SizedBox(
                            height: 8.0,
                          ),
                          Text(
                            'BOD',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 13.0,
                            ),
                          ),
                          SizedBox(
                            height: 4.0,
                          ),
                          Text(
                            data.jumlahDireksi.toString(),
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 13.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      SizedBox(
        height: 8.0,
      ),
      BaseCard(
        title: 'Anak Perusahaan',
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 8.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () => widget.actionMapper.openBod1ByCompany(),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          border: Border.all(
                            color: Color(0xFF1FA4CA),
                            width: 1.0,
                          )),
                      padding: EdgeInsets.only(
                        left: 8.0,
                        right: 8.0,
                        top: 16.0,
                        bottom: 8.0,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            'res/images/ic_building.png',
                            height: 24.0,
                            color: Color(0xFF1FA4CA),
                          ),
                          SizedBox(
                            height: 8.0,
                          ),
                          Text(
                            'Perusahaan',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 13.0,
                            ),
                          ),
                          SizedBox(
                            height: 4.0,
                          ),
                          Text(
                            data.totalBumnAp.toString(),
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 13.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 8.0,
                ),
                Expanded(
                  child: InkWell(
                    onTap: () =>
                        widget.actionMapper.openDewanKomisarisByCompany(),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          border: Border.all(
                            color: Color(0xFF1FA4CA),
                            width: 1.0,
                          )),
                      padding: EdgeInsets.only(
                        left: 8.0,
                        right: 8.0,
                        top: 16.0,
                        bottom: 8.0,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            'res/images/ic_boc.png',
                            height: 24.0,
                            color: Color(0xFF1FA4CA),
                          ),
                          SizedBox(
                            height: 8.0,
                          ),
                          Text(
                            'BOC',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 13.0,
                            ),
                          ),
                          SizedBox(
                            height: 4.0,
                          ),
                          Text(
                            data.jumlahKomisarisAp.toString(),
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 13.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 8.0,
                ),
                Expanded(
                  child: InkWell(
                    onTap: () => widget.actionMapper.openBodByCompany(),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          border: Border.all(
                            color: Color(0xFF1FA4CA),
                            width: 1.0,
                          )),
                      padding: EdgeInsets.only(
                        left: 8.0,
                        right: 8.0,
                        top: 16.0,
                        bottom: 8.0,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            'res/images/ic_boc.png',
                            height: 24.0,
                            color: Color(0xFF1FA4CA),
                          ),
                          SizedBox(
                            height: 8.0,
                          ),
                          Text(
                            'BOD',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 13.0,
                            ),
                          ),
                          SizedBox(
                            height: 4.0,
                          ),
                          Text(
                            data.jumlahDireksiAp.toString(),
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 13.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      SizedBox(
        height: 8.0,
      ),
      BaseCard(
        title: 'Cucu Perusahaan',
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 8.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        border: Border.all(
                          color: Color(0xFF1FA4CA),
                          width: 1.0,
                        )),
                    padding: EdgeInsets.only(
                      left: 8.0,
                      right: 8.0,
                      top: 16.0,
                      bottom: 8.0,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          'res/images/ic_building.png',
                          height: 24.0,
                          color: Color(0xFF1FA4CA),
                        ),
                        SizedBox(
                          height: 8.0,
                        ),
                        Text(
                          'Perusahaan',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 13.0,
                          ),
                        ),
                        SizedBox(
                          height: 4.0,
                        ),
                        Text(
                          data.totalBumnCucu.toString(),
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 13.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: 8.0,
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        border: Border.all(
                          color: Color(0xFF1FA4CA),
                          width: 1.0,
                        )),
                    padding: EdgeInsets.only(
                      left: 8.0,
                      right: 8.0,
                      top: 16.0,
                      bottom: 8.0,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          'res/images/ic_boc.png',
                          height: 24.0,
                          color: Color(0xFF1FA4CA),
                        ),
                        SizedBox(
                          height: 8.0,
                        ),
                        Text(
                          'BOC',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 13.0,
                          ),
                        ),
                        SizedBox(
                          height: 4.0,
                        ),
                        Text(
                          data.jumlahKomisarisCucu.toString(),
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 13.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: 8.0,
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        border: Border.all(
                          color: Color(0xFF1FA4CA),
                          width: 1.0,
                        )),
                    padding: EdgeInsets.only(
                      left: 8.0,
                      right: 8.0,
                      top: 16.0,
                      bottom: 8.0,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          'res/images/ic_boc.png',
                          height: 24.0,
                          color: Color(0xFF1FA4CA),
                        ),
                        SizedBox(
                          height: 8.0,
                        ),
                        Text(
                          'BOD',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 13.0,
                          ),
                        ),
                        SizedBox(
                          height: 4.0,
                        ),
                        Text(
                          data.jumlahDireksiCucu.toString(),
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 13.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      SizedBox(
        height: 8.0,
      ),
      BaseCard(
        title: 'Talent Pool',
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 8.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () => widget.actionMapper.openProfileTalent(),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          border: Border.all(
                            color: Color(0xFF1FA4CA),
                            width: 1.0,
                          )),
                      padding: EdgeInsets.only(
                        left: 16.0,
                        right: 16.0,
                        top: 16.0,
                        bottom: 16.0,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            'res/images/ic_building.png',
                            height: 24.0,
                            color: Color(0xFF1FA4CA),
                          ),
                          SizedBox(
                            width: 8.0,
                          ),
                          Text(
                            'Total Talent',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 12.0,
                            ),
                          ),
                          Spacer(),
                          Text(
                            data.totalTalentResources.toString(),
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 13.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 8.0,
            ),
            InkWell(
              onTap: () => widget.actionMapper.openTalentPool(),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Container(
                      constraints: BoxConstraints(
                        minHeight: 120.0,
                      ),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          border: Border.all(
                            color: Color(0xFF1FA4CA),
                            width: 1.0,
                          )),
                      padding: EdgeInsets.only(
                        left: 4.0,
                        right: 4.0,
                        top: 16.0,
                        bottom: 8.0,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            'res/images/ic_building.png',
                            height: 24.0,
                            color: Color(0xFF1FA4CA),
                          ),
                          SizedBox(
                            height: 8.0,
                          ),
                          Text(
                            'Ready',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 12.0,
                            ),
                          ),
                          SizedBox(
                            height: 4.0,
                          ),
                          Text(
                            data.readyTalentSource.toString(),
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 13.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 8.0,
                  ),
                  Expanded(
                    child: Container(
                      constraints: BoxConstraints(
                        minHeight: 120.0,
                      ),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          border: Border.all(
                            color: Color(0xFF1FA4CA),
                            width: 1.0,
                          )),
                      padding: EdgeInsets.only(
                        left: 4.0,
                        right: 4.0,
                        top: 16.0,
                        bottom: 8.0,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            'res/images/ic_boc.png',
                            height: 24.0,
                            color: Color(0xFF1FA4CA),
                          ),
                          SizedBox(
                            height: 8.0,
                          ),
                          Text(
                            'Eligible',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 12.0,
                            ),
                          ),
                          SizedBox(
                            height: 4.0,
                          ),
                          Text(
                            data.eligibleTalentSource.toString(),
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 13.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 8.0,
                  ),
                  Expanded(
                    child: Container(
                      constraints: BoxConstraints(
                        minHeight: 120.0,
                      ),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          border: Border.all(
                            color: Color(0xFF1FA4CA),
                            width: 1.0,
                          )),
                      padding: EdgeInsets.only(
                        left: 4.0,
                        right: 4.0,
                        top: 16.0,
                        bottom: 8.0,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            'res/images/ic_boc.png',
                            height: 24.0,
                            color: Color(0xFF1FA4CA),
                          ),
                          SizedBox(
                            height: 8.0,
                          ),
                          Text(
                            'Nominated',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 12.0,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                            height: 4.0,
                          ),
                          Text(
                            data.nominatedTalentSource.toString(),
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 13.0,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 8.0,
                  ),
                  Expanded(
                    child: Container(
                      constraints: BoxConstraints(
                        minHeight: 120.0,
                      ),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          border: Border.all(
                            color: Color(0xFF1FA4CA),
                            width: 1.0,
                          )),
                      padding: EdgeInsets.only(
                        left: 4.0,
                        right: 4.0,
                        top: 16.0,
                        bottom: 8.0,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            'res/images/ic_boc.png',
                            height: 24.0,
                            color: Color(0xFF1FA4CA),
                          ),
                          SizedBox(
                            height: 8.0,
                          ),
                          Text(
                            'Selected',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 12.0,
                            ),
                          ),
                          SizedBox(
                            height: 4.0,
                          ),
                          Text(
                            data.selectedTalentSource.toString(),
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 13.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      SizedBox(
        height: 16.0,
      ),
    ];
  }

  List<Widget> summary(
    BuildContext context,
  ) {
    return [
      SizedBox(
        height: 16.0,
      ),
      BaseCard(
        title: 'Summary',
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 8.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        border: Border.all(
                          color: Color(0xFF1FA4CA),
                          width: 1.0,
                        )),
                    padding: EdgeInsets.only(
                      left: 8.0,
                      right: 8.0,
                      top: 16.0,
                      bottom: 8.0,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Total Perusahaan',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 13.0,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: 4.0,
                        ),
                        Text(
                          data.totalBumn.toString(),
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 13.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: 8.0,
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        border: Border.all(
                          color: Color(0xFF1FA4CA),
                          width: 1.0,
                        )),
                    padding: EdgeInsets.only(
                      left: 8.0,
                      right: 8.0,
                      top: 16.0,
                      bottom: 8.0,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Total Anggaran',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 13.0,
                          ),
                        ),
                        SizedBox(
                          height: 4.0,
                        ),
                        Text(
                          '-',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 13.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 8.0,
            ),
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () => widget.actionMapper.openKaryawan(),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          border: Border.all(
                            color: Color(0xFF1FA4CA),
                            width: 1.0,
                          )),
                      padding: EdgeInsets.only(
                        left: 8.0,
                        right: 8.0,
                        top: 16.0,
                        bottom: 8.0,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Total Karyawan',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 13.0,
                            ),
                          ),
                          SizedBox(
                            height: 4.0,
                          ),
                          Text(
                            data.totalPegawai.toString(),
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 13.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 8.0,
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        border: Border.all(
                          color: Color(0xFF1FA4CA),
                          width: 1.0,
                        )),
                    padding: EdgeInsets.only(
                      left: 8.0,
                      right: 8.0,
                      top: 16.0,
                      bottom: 8.0,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Total BOC',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 13.0,
                          ),
                        ),
                        SizedBox(
                          height: 4.0,
                        ),
                        Text(
                          data.bocTotal.toString(),
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 13.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: 8.0,
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        border: Border.all(
                          color: Color(0xFF1FA4CA),
                          width: 1.0,
                        )),
                    padding: EdgeInsets.only(
                      left: 8.0,
                      right: 8.0,
                      top: 16.0,
                      bottom: 8.0,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Total BOD',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 13.0,
                          ),
                        ),
                        SizedBox(
                          height: 4.0,
                        ),
                        Text(
                          data.bodTotal.toString(),
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 13.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: 8.0,
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        border: Border.all(
                          color: Color(0xFF1FA4CA),
                          width: 1.0,
                        )),
                    padding: EdgeInsets.only(
                      left: 8.0,
                      right: 8.0,
                      top: 16.0,
                      bottom: 8.0,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Total BOD-1',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 13.0,
                          ),
                        ),
                        SizedBox(
                          height: 4.0,
                        ),
                        Text(
                          data.bod1Total.toString(),
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 13.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      SizedBox(
        height: 16.0,
      ),
      BaseCard(
        title: 'Umur Karyawan',
        child: HorizontalBarChart(
          data: {
            '> 56 Tahun': data.umurA,
            '46-55 Tahun': data.umurB,
            '36-45 Tahun': data.umurC,
            '26-35 Tahun': data.umurD,
          },
        ),
      ),
      SizedBox(
        height: 16.0,
      ),
      LayoutBuilder(
        builder: (ctx, constraints) {
          final total = data.laki + data.perempuan;
          final lakiPercentage = ((data.laki / total) * 100).toStringAsFixed(2);
          final perempuanPercentage =
              ((data.perempuan / total) * 100).toStringAsFixed(2);
          return BaseCard(
            title: 'Gender Perusahaan Induk',
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        'res/images/ic_man.png',
                        height: 24.0,
                      ),
                      SizedBox(
                        width: 8.0,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${data.laki} (${lakiPercentage}%)',
                            style: TextStyle(
                              fontSize: 13.0,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 8.0,
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        'res/images/ic_woman.png',
                        height: 24.0,
                      ),
                      SizedBox(
                        width: 8.0,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${data.perempuan} (${perempuanPercentage}%)',
                            style: TextStyle(
                              fontSize: 13.0,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
      SizedBox(
        height: 16.0,
      ),
    ];
  }

  Widget filterItem(
    BuildContext context,
    String title,
    String key,
  ) {
    return InkWell(
      onTap: () {
        setState(() {
          currentKey = key;
        });
      },
      child: Container(
        constraints: BoxConstraints(
          minHeight: 75.0,
        ),
        decoration: BoxDecoration(
          color: currentKey == key ? Color(0xFF1FA4CA) : Colors.white,
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 0.0,
              blurRadius: 4,
              offset: Offset(0, 5), // changes position of shadow
            ),
          ],
        ),
        padding: EdgeInsets.symmetric(
          vertical: 16.0,
          horizontal: 16.0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'res/images/ic_wamen_2.png',
              height: 20.0,
              color: currentKey == key ? Colors.white : Color(0xFF1FA4CA),
            ),
            SizedBox(
              width: 8.0,
            ),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontFamily: 'poppins',
                  fontWeight: FontWeight.w500,
                  fontSize: 14.0,
                  color: currentKey == key ? Colors.white : Color(0xFF1FA4CA),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget menuList(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      margin: EdgeInsets.only(top: 16),
      child: ListView(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: filterItem(
                  context,
                  'Menu Dashboard',
                  'dashboard',
                ),
              ),
              SizedBox(
                width: 8.0,
              ),
              Expanded(
                child: filterItem(
                  context,
                  'Summary',
                  'summary',
                ),
              ),
            ],
          ),
          // containerMenu(
          //     title: "Perusahaan Induk",
          //     count: "${data.totalBumn} Perusahaan",
          //     bgColor: Color(0xFF6A7EE5),
          //     child: Row(
          //       mainAxisAlignment: MainAxisAlignment.start,
          //       crossAxisAlignment: CrossAxisAlignment.center,
          //       children: <Widget>[
          //         insideMenu(
          //             count: data.jumlahKomisaris,
          //             name: "BOC",
          //             onTap: () => widget.actionMapper.openDewanKomisaris()),
          //         insideMenu(
          //             count: data.jumlahDireksi,
          //             name: "BOD",
          //             onTap: () => widget.actionMapper.openBod()),
          //         insideMenu(
          //             count: data.bod1Total,
          //             name: "BOD-1",
          //             onTap: () => widget.actionMapper.openBod1()),
          //         insideMenu(
          //             count: data.totalPegawai,
          //             name: "Karyawan",
          //             onTap: () => widget.actionMapper.openKaryawan()),
          //       ],
          //     )),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.start,
          //   crossAxisAlignment: CrossAxisAlignment.start,
          //   children: <Widget>[
          //     Expanded(
          //       child: containerMenu(
          //           title: "Anak Perusahaan",
          //           count: "${data.totalBumnAp} Perusahaan",
          //           bgColor: Color(0xFF6C6AE5),
          //           child: Row(
          //             mainAxisAlignment: MainAxisAlignment.start,
          //             crossAxisAlignment: CrossAxisAlignment.center,
          //             children: <Widget>[
          //               insideMenu(
          //                   count: data.jumlahKomisarisAp,
          //                   name: "BOC",
          //                   onTap: () => widget.actionMapper
          //                       .openDewanKomisarisByCompany()),
          //               insideMenu(
          //                   count: data.jumlahDireksiAp,
          //                   name: "BOD",
          //                   onTap: () =>
          //                       widget.actionMapper.openBodByCompany()),
          //             ],
          //           )),
          //     ),
          //     Expanded(
          //       child: containerMenu(
          //           title: "Cucu Perusahaan",
          //           count: "${data.totalBumnCucu} Perusahaan",
          //           bgColor: Color(0xFF956CEC),
          //           child: Row(
          //             mainAxisAlignment: MainAxisAlignment.start,
          //             crossAxisAlignment: CrossAxisAlignment.center,
          //             children: <Widget>[
          //               insideMenu(
          //                   count: data.jumlahKomisarisCucu,
          //                   name: "BOC",
          //                   onTap: () => widget.actionMapper
          //                       .openDewanKomisarisByCompany()),
          //               insideMenu(
          //                   count: data.jumlahDireksiCucu,
          //                   name: "BOD",
          //                   onTap: () =>
          //                       widget.actionMapper.openBodByCompany()),
          //             ],
          //           )),
          //     ),
          //   ],
          // ),
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
          //   child: Text(
          //     "Talent Pool",
          //     style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18.0),
          //   ),
          // ),
          // containerMenu(
          //   title: "Talent Pool",
          //   count: "${data.totalTalentResources} Talent",
          //   bgColor: Color(0xFF6AAAE5),
          //   onTap: () => widget.actionMapper.openTalentPool(),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.start,
          //     crossAxisAlignment: CrossAxisAlignment.center,
          //     children: <Widget>[
          //       insideMenu(
          //           count: data.readyTalentSource,
          //           name: "Ready",
          //           onTap: () => widget.actionMapper.openTalentPool()),
          //       insideMenu(
          //           count: data.eligibleTalentSource,
          //           name: "Eligible",
          //           onTap: () => widget.actionMapper.openTalentPool()),
          //       insideMenu(
          //           count: data.nominatedTalentSource,
          //           name: "Nominated",
          //           onTap: () => widget.actionMapper.openTalentPool()),
          //       insideMenu(
          //           count: data.selectedTalentSource,
          //           name: "Selected",
          //           onTap: () => widget.actionMapper.openTalentPool()),
          //     ],
          //   ),
          // ),
          // Padding(
          //   padding: const EdgeInsets.symmetric(vertical: 8.0),
          //   child: LastUpdateWidget(
          //     store: widget.store,
          //     pageName: "hc",
          //   ),
          // ),
        ]..addAll(
            currentKey == 'dashboard' ? dashboard(context) : summary(context),
          ),
      ),
    );
  }

  Widget mainWidget(BuildContext context) {
    return !isDataReady()
        ? isError
            ? CustomErrorWidget(
                onRetry: () => getData(),
              )
            : LoadingWidget(
                colorPalette: widget.colorPalette,
              )
        : menuList(context);
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      title: 'Human Capital',
      body: (ctx) => mainWidget(ctx),
    );
  }
}
