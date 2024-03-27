import 'package:after_layout/after_layout.dart';
import 'package:bumn_eid/core/controllers/companies_controller.dart';
import 'package:bumn_eid/core/di/injectable_widget.dart';
import 'package:bumn_eid/core/models/business_portfolio/profil_perusahaan.dart';
import 'package:bumn_eid/core/models/common/anak_perusahaan.dart';
import 'package:bumn_eid/core/models/hc/dirkom.dart';
import 'package:bumn_eid/core/redux/states/app_state/app_state.dart';
import 'package:bumn_eid/irwan_dev/services/api_statistic.dart';
import 'package:bumn_eid/ui/components/base_scaffold.dart';
import 'package:bumn_eid/ui/components/custom_error_widget.dart';
import 'package:bumn_eid/ui/components/custom_expansion_tile.dart';
import 'package:bumn_eid/ui/components/custom_table.dart';
import 'package:bumn_eid/ui/components/loading_widget.dart';
import 'package:bumn_eid/ui/components/one_row_item.dart';
import 'package:bumn_eid/ui/components/triangle_painter.dart';
import 'package:bumn_eid/ui/pages/common/company_detail_page/company_detail_action_mapper.dart';
import 'package:bumn_eid/ui/pages/common/company_detail_page/di/company_detail_page_graph.dart';
import 'package:bumn_eid/ui/utils/color_palette.dart';
import 'package:bumn_eid/ui/utils/widget_utils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';

// ignore: must_be_immutable
class CompanyDetailPage extends StatefulWidget with InjectableWidget {
  final CompanyDetailPageGraph _graph;

  final String id;

  //injected
  ColorPalette colorPalette;

  //injected
  Store<AppState> store;

  //injected
  CompaniesController companiesController;

  //injected
  CompanyDetailActionMapper actionMapper;

  CompanyDetailPage({@required this.id, CompanyDetailPageGraph graph})
      : this._graph = graph ?? CompanyDetailPageGraph() {
    setup();
  }

  @override
  CompanyDetailPageGraph graph() => _graph;

  @override
  _CompanyDetailPageState createState() => _CompanyDetailPageState();
}

class _CompanyDetailPageState extends State<CompanyDetailPage>
    with AfterLayoutMixin<CompanyDetailPage> {
  bool isError = false;

  List<AnakPerusahaan> anakPerusahaan;
  Map<DirkomType, List<Dirkom>> dirkom;
  ProfilPerusahaan company;

  @override
  void afterFirstLayout(BuildContext context) {
    getData();
  }

  bool isDataReady() {
    return company != null && dirkom != null && anakPerusahaan != null;
  }

  // TODO: disini jg mau diubah
  void getData() async {
    try {
      setState(() {
        this.isError = false;
      });
      final fetchedCompany =
          await widget.companiesController.fetchCompany(id: widget.id);
      final dirkom =
          await widget.companiesController.fetchDirkom(companyId: widget.id);
      final anakPerusahaan = await widget.companiesController
          .fetchAnakPerusahaan(companyId: widget.id);

      setState(() {
        this.company = fetchedCompany;
        this.dirkom = dirkom;
        this.anakPerusahaan = anakPerusahaan;
      });
    } catch (ex) {
      print(ex.toString());
      setState(() {
        this.isError = true;
      });
    }
  }

  Widget menuItem(
    BuildContext context,
    String title,
    String image,
    VoidCallback onTap,
  ) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Container(
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height * 0.135,
          ),
          decoration: BoxDecoration(
            color: Color(0xFF1FA4CA),
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
            horizontal: 16.0,
            vertical: 16.0,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                image,
                color: Colors.white,
                height: 26.0,
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
                    fontSize: 12.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget menuList(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: 16.0,
        ),
        IntrinsicHeight(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              menuItem(
                context,
                'Kinerja Perusahaan',
                'res/images/kinerja.png',
                () {
                  ApiStatistic().insertStatistic("Business Portofolio",
                      "Kinerja Perusahaan Detail Company ${widget.id} Total BUMN");
                  widget.actionMapper.openKinerjaPerusahaan(widget.id);
                },
              ),
              SizedBox(
                width: 16.0,
              ),
              menuItem(
                context,
                "Kontribusi Kepada Negara",
                "res/images/kontribusi.png",
                () {
                  ApiStatistic().insertStatistic("Business Portofolio",
                      "Kontribusi Kepada Negara Detail Company ${widget.id} Total BUMN");
                  widget.actionMapper.openKontribusiNegara(widget.id);
                },
              ),
            ],
          ),
        ),
        // SizedBox(
        //   height: 8.0,
        // ),
        // IntrinsicHeight(
        //   child: Row(
        //     mainAxisAlignment: MainAxisAlignment.center,
        //     crossAxisAlignment: CrossAxisAlignment.center,
        //     children: <Widget>[
        //       menuItem(
        //         context,
        //         'Operasional Perusahaan',
        //         'res/images/operasional.png',
        //         () {
        //           widget.actionMapper.openOperasionalPerusahaan(widget.id);
        //         },
        //       ),
        //       SizedBox(
        //         width: 16.0,
        //       ),
        //       menuItem(
        //         context,
        //         'Human Capital',
        //         'res/images/humancapital.png',
        //         () {
        //           widget.actionMapper.openCompanyHCPage(company.id);
        //         },
        //       ),
        //       // menuItem(
        //       //   context,
        //       //   "Keuangan",
        //       //   "res/images/finance.png",
        //       //   () {
        //       //     widget.actionMapper.featureNotAvailable();
        //       //   },
        //       // ),
        //     ],
        //   ),
        // ),
        SizedBox(
          height: 8.0,
        ),
        // IntrinsicHeight(
        //   child: Row(
        //     mainAxisAlignment: MainAxisAlignment.center,
        //     crossAxisAlignment: CrossAxisAlignment.center,
        //     children: <Widget>[
        //       SizedBox(
        //         width: 16.0,
        //       ),
        //       menuItem(
        //         context,
        //         "Legal",
        //         "res/images/legalcompany.png",
        //         () {
        //           widget.actionMapper.featureNotAvailable();
        //         },
        //       ),
        //     ],
        //   ),
        // ),
        // SizedBox(
        //   height: 8.0,
        // ),
        IntrinsicHeight(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              menuItem(
                context,
                'CSR',
                'res/images/csrcompany.png',
                () {
                  ApiStatistic().insertStatistic("Business Portofolio",
                      "CSR Detail Company ${widget.id} Total BUMN");
                  widget.actionMapper.openCompanyCSRDetailPage(company.id);
                },
              ),
              SizedBox(
                width: 16.0,
              ),
              menuItem(
                context,
                "Cosmic",
                "res/images/cosmiccompany.png",
                () {
                  ApiStatistic().insertStatistic("Business Portofolio",
                      "Cosmic Detail Company ${widget.id} Total BUMN");
                  // widget.actionMapper.openCompanyCosmicDetailPage(company.id);
                  widget.actionMapper.openCompanyCosmicDetailPage(company.id);
                },
              ),
            ],
          ),
        ),
        SizedBox(
          height: 8.0,
        ),
      ],
    );
  }

  Widget companyInfo(BuildContext context) {
    print("mantakk ${widget.id}");

    String sahamPemerintah = company.sahamPemerintah == null
        ? "0"
        : parseDouble(company.sahamPemerintah).toStringAsFixed(2);
    String sahamPublik = company.sahamPublik == null
        ? "0"
        : parseDouble(company.sahamPublik).toStringAsFixed(2);
    return CustomExpansionTile(
      colorPalette: widget.colorPalette,
      text: "Informasi Perusahaan",
      children: <Widget>[
        Container(
          color: widget.colorPalette.white,
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              OneRowItem(
                title: "Alamat",
                content: company.alamat,
              ),
              OneRowItem(
                title: "Telp",
                content: company.telepon,
              ),
              OneRowItem(
                title: "Fax",
                content: company.fax,
              ),
              OneRowItem(
                title: "Website",
                content: company.website,
              ),
              OneRowItem(
                  title: "Kepemilikan",
                  content:
                      "Pemerintah $sahamPemerintah% | Publik $sahamPublik%"),
              Divider(
                color: widget.colorPalette.softerPrimary,
              ),
              OneRowItem(
                title: "Bidang Usaha",
                content: cleanseString(company.bidangUsaha),
                isHtml: true,
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget issue(BuildContext context) {
    bool isEmpty = company.isu == null || company.isu.isEmpty;
    // if (isEmpty) return Container();
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: CustomExpansionTile(
        colorPalette: widget.colorPalette,
        text: "Isu dan Permasalahan",
        children: <Widget>[
          Container(
            color: widget.colorPalette.white,
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.all(16.0),
            child: company.isu == null || company.isu.isEmpty
                ? Text("Data tidak tersedia.")
                : Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      OneRowItem(
                        title: "Isu dan Permasalahan Strategis",
                        content: cleanseString(company.isu),
                        isHtml: true,
                      ),
                    ],
                  ),
          )
        ],
      ),
    );
  }

  Widget groupStructure(BuildContext context) {
    bool isEmpty = company.group == null || company.group.isEmpty;
    // if (isEmpty) return Container();
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: CustomExpansionTile(
        colorPalette: widget.colorPalette,
        text: "Struktur Grup",
        children: <Widget>[
          Container(
              color: widget.colorPalette.white,
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.all(8.0),
              child: company.group == null || company.group.isEmpty
                  ? Text(
                      "Data tidak tersedia.",
                      style: TextStyle(fontSize: 18.0),
                    )
                  : InkWell(
                      onTap: () =>
                          widget.actionMapper.openImageDialog(company.group),
                      child: Text(
                        "Gambar Struktur Grup",
                        style: TextStyle(
                            color: Colors.blue,
                            decoration: TextDecoration.underline,
                            fontSize: 18.0),
                      ),
                    ))
        ],
      ),
    );
  }

  Widget commisioner(BuildContext context) {
    bool isEmpty = dirkom[DirkomType.KOMISARIS] == null ||
        dirkom[DirkomType.KOMISARIS].isEmpty;
    if (isEmpty) return Container();
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: CustomExpansionTile(
        colorPalette: widget.colorPalette,
        text: "Komisaris",
        padding: EdgeInsets.zero,
        children: <Widget>[
          dirkom[DirkomType.KOMISARIS] == null ||
                  dirkom[DirkomType.KOMISARIS].isEmpty
              ? Container(
                  color: Color(0xFFE7F0FF),
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.all(8.0),
                  child: Text("Data tidak tersedia"))
              : CustomTable(
                  colorPalette: widget.colorPalette,
                  margin: EdgeInsets.zero,
                  data: dirkom[DirkomType.KOMISARIS]
                      .asMap()
                      .map((k, v) => MapEntry(v.nama, v)),
                  withShadow: false,
                  showTriliun: false,
                  headers: [
                    TableText(text: "Nama", flexColumnWidth: 100),
                    TableText(text: "Jabatan", flexColumnWidth: 100),
                  ],
                  rowDescriptor: (key, value) => TableRow(children: [
                    cell(
                      text: key,
                    ),
                    cell(text: value.jabatan),
                  ]),
                )
        ],
      ),
    );
  }

  Widget directors(BuildContext context) {
    bool isEmpty = dirkom[DirkomType.DIREKTUR] == null ||
        dirkom[DirkomType.DIREKTUR].isEmpty;
    if (isEmpty) return Container();
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: CustomExpansionTile(
        colorPalette: widget.colorPalette,
        text: "Direksi",
        padding: EdgeInsets.zero,
        children: <Widget>[
          dirkom[DirkomType.DIREKTUR] == null ||
                  dirkom[DirkomType.DIREKTUR].isEmpty
              ? Container(
                  color: Color(0xFFE7F0FF),
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Data belum tersedia",
                    style: TextStyle(fontSize: 18.0),
                  ))
              : CustomTable(
                  colorPalette: widget.colorPalette,
                  margin: EdgeInsets.zero,
                  data: dirkom[DirkomType.DIREKTUR]
                      .asMap()
                      .map((key, value) => MapEntry(value.nama, value)),
                  withShadow: false,
                  showTriliun: false,
                  headers: [
                    TableText(text: "Nama", flexColumnWidth: 100),
                    TableText(text: "Jabatan", flexColumnWidth: 100),
                  ],
                  rowDescriptor: (key, value) => TableRow(children: [
                    cell(
                      text: key,
                    ),
                    cell(text: value.jabatan),
                  ]),
                )
        ],
      ),
    );
  }

  // Widget businessProcess(BuildContext context) {
  // bool isEmpty = company.bisnisProses == null || company.bisnisProses.isEmpty;
  // if (isEmpty) return Container();
  //   return Padding(
  //     padding: const EdgeInsets.only(top: 16.0),
  //     child: CustomExpansionTile(
  //       colorPalette: widget.colorPalette,
  //       text: "Bisnis Proses",
  //       children: <Widget>[
  //         Container(
  //             color: Color(0xFFE7F0FF),
  //             width: MediaQuery.of(context).size.width,
  //             padding: EdgeInsets.all(8.0),
  //             child: InkWell(
  //               onTap: () =>
  //                   widget.actionMapper.openImageDialog(company.bisnisProses),
  //               child: Text(
  //                 "Gambar Bisnis Proses",
  //                 style: TextStyle(
  //                     color: Colors.blue,
  //                     decoration: TextDecoration.underline,
  //                     fontSize: 18.0),
  //               ),
  //             ))
  //       ],
  //     ),
  //   );
  // }

  Widget businessProcess(BuildContext context) {
    bool isEmpty = company.bisnisProses == null || company.bisnisProses.isEmpty;
    // if (isEmpty) return Container();
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: CustomExpansionTile(
        colorPalette: widget.colorPalette,
        text: "Bisnis Proses",
        children: <Widget>[
          Container(
              color: Color(0xFFE7F0FF),
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.all(8.0),
              child: company.group == null || company.group.isEmpty
                  ? Text(
                      "Data tidak tersedia.",
                      style: TextStyle(fontSize: 18.0),
                    )
                  : InkWell(
                      onTap: () => widget.actionMapper
                          .openImageDialog(company.bisnisProses),
                      child: Text(
                        "Gambar Bisnis Proses",
                        style: TextStyle(
                            color: Colors.blue,
                            decoration: TextDecoration.underline,
                            fontSize: 18.0),
                      ),
                    ))
        ],
      ),
    );
  }

  Widget childCompanies(BuildContext context) {
    bool isEmpty = anakPerusahaan == null || anakPerusahaan.isEmpty;
    // if (isEmpty) return Container();
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: CustomExpansionTile(
        colorPalette: widget.colorPalette,
        text: "Anak Perusahaan",
        padding: EdgeInsets.zero,
        children: <Widget>[
          anakPerusahaan == null || anakPerusahaan.isEmpty
              ? Container(
                  color: Color(0xFFE7F0FF),
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Data Tidak tersedia",
                    style: TextStyle(fontSize: 18.0),
                  ))
              : CustomTable(
                  colorPalette: widget.colorPalette,
                  data:
                      anakPerusahaan.asMap().map((k, v) => MapEntry(v.anak, v)),
                  margin: EdgeInsets.zero,
                  withShadow: false,
                  showTriliun: false,
                  headers: [
                    TableText(text: "Nama", flexColumnWidth: 100),
                    TableText(
                        text: "Kepemilikan %",
                        type: TableTextType.NUMBER,
                        flexColumnWidth: 75),
                  ],
                  rowDescriptor: (key, AnakPerusahaan value) =>
                      TableRow(children: [
                    cell(
                      text: key,
                    ),
                    cell(
                        text: parseDouble(value.persentase).toStringAsFixed(2),
                        textAlign: TextAlign.end),
                  ]),
                )
        ],
      ),
    );
  }

  Widget detailsList(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          companyInfo(context),
          issue(context),
          groupStructure(context),
          commisioner(context),
          directors(context),
          businessProcess(context),
          childCompanies(context),
        ],
      ),
    );
  }

  Widget companyImage(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 84.0,
      width: 84.0,
      child: CachedNetworkImage(
        imageUrl: company.logo,
        placeholder: (context, _) => CircularProgressIndicator(
          valueColor:
              new AlwaysStoppedAnimation<Color>(widget.colorPalette.primary),
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
        : Container(
            color: widget.colorPalette.defaultBg,
            height: MediaQuery.of(context).size.height,
            child: ListView(
              shrinkWrap: true,
              children: <Widget>[
                Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.35,
                  child: Stack(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: double.infinity,
                            height:
                                (MediaQuery.of(context).size.height * 0.35) *
                                    0.55,
                            color: Color(0xFF1F2855),
                          ),
                          Container(
                            width: double.infinity,
                            height:
                                (MediaQuery.of(context).size.height * 0.35) *
                                    0.45,
                            color: Color(0xFFf0f4fa),
                          ),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            margin: EdgeInsets.symmetric(
                              horizontal: 16.0,
                            ),
                            padding: EdgeInsets.all(16.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                companyImage(context),
                                Padding(
                                  padding: const EdgeInsets.only(top: 16.0),
                                  child: Center(
                                    child: Text(
                                      company.nama,
                                      style: TextStyle(
                                        color: widget.colorPalette.darkGrey,
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.w700,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16.0,
                            ),
                            child: CustomPaint(
                              painter: TrianglePainter(
                                strokeColor: Colors.white,
                                strokeWidth: 1.0,
                                paintingStyle: PaintingStyle.fill,
                                upsideDown: true,
                              ),
                              child: Container(
                                width: double.infinity,
                                height: 50.0,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                  ),
                  child: menuList(context),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                  ),
                  child: detailsList(context),
                ),
                SizedBox(
                  height: 16.0,
                ),
              ],
            ),
          );
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      title: "Profil BUMN",
      body: (ctx) => mainWidget(context),
    );
  }
}
