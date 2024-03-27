import 'package:after_layout/after_layout.dart';
import 'package:bumn_eid/core/controllers/finance_controller.dart';
import 'package:bumn_eid/core/di/injectable_widget.dart';
import 'package:bumn_eid/core/models/finance/third_party_loan.dart';
import 'package:bumn_eid/core/redux/states/app_state/app_state.dart';
import 'package:bumn_eid/core/utils/constants.dart';
import 'package:bumn_eid/ui/components/base_scaffold.dart';
import 'package:bumn_eid/ui/components/custom_error_widget.dart';
import 'package:bumn_eid/ui/components/custom_table.dart';
import 'package:bumn_eid/ui/components/filter_widget.dart';
import 'package:bumn_eid/ui/components/loading_widget.dart';
import 'package:bumn_eid/ui/pages/finance/loan/third_party_loan/third_party_loan_page/di/third_party_loan_page_graph.dart';
import 'package:bumn_eid/ui/utils/color_palette.dart';
import 'package:bumn_eid/ui/utils/widget_utils.dart';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';

import 'third_party_loan_action_mapper.dart';

// ignore: must_be_immutable
class ThirdPartyLoanPage extends StatefulWidget with InjectableWidget {
  final ThirdPartyLoanPageGraph _graph;

  //injected
  ColorPalette colorPalette;
  //injected
  ThirdPartyLoanActionMapper actionMapper;
  //injected
  FinanceController financeController;
  //injected
  Store<AppState> store;

  @override
  ThirdPartyLoanPageGraph graph() => _graph;

  ThirdPartyLoanPage([graph])
      : this._graph = graph ?? ThirdPartyLoanPageGraph() {
    setup();
  }

  @override
  _ThirdPartyLoanPageState createState() => _ThirdPartyLoanPageState();
}

class _ThirdPartyLoanPageState extends State<ThirdPartyLoanPage>
    with AfterLayoutMixin<ThirdPartyLoanPage> {
  bool isError = false;

  String currentTahun = "2019";
  List<String> tahunList = ["2017", "2018", "2019"];
  Map<String, List<ThirdPartyLoan>> loan;
  Map<String, List<ThirdPartyLoan>> filteredThirdPartyLoan;
  TextEditingController _searchController = TextEditingController();

  @override
  void afterFirstLayout(BuildContext context) {
    getData();
  }

  void getData() async {
    try {
      setState(() {
        this.isError = false;
      });
      Map<String, List<ThirdPartyLoan>> data = {};
      List<ThirdPartyLoan> companies =
          await widget.financeController.fetchThirdPartyLoan();

      companies.forEach((company) {
        if (data.containsKey(company.namaPerusahaan)) {
          data[company.namaPerusahaan].add(company);
        } else {
          data[company.namaPerusahaan] = [company];
        }
      });

      setState(() {
        this.loan = data;
      });
    } catch (ex) {
      print(ex);
      setState(() {
        this.isError = true;
      });
    }
  }

  @override
  void dispose() {
    _searchController?.dispose();
    super.dispose();
  }

  void filterCompany(String query) {
    if (ThirdPartyLoan == null) return;
    Map<String, List<ThirdPartyLoan>> filtered = {};
    final filteredKeys = loan.keys.where((key) {
      return key.toLowerCase().contains(query.toLowerCase());
    }).toList();
    filteredKeys.forEach((key) {
      filtered[key] = loan[key];
    });

    setState(() {
      this.filteredThirdPartyLoan = filtered;
    });
  }

  Widget searchBar(BuildContext context) {
    return TextField(
      controller: _searchController,
      onChanged: (query) => filterCompany(query),
      decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
          filled: true,
          labelText: "Cari perusahaan disini",
          hintText: "Masukkan nama perusahaan. e.g. Mandiri"),
    );
  }

  Widget queryNotFoundError(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Center(
        child: Text(
          "Mohon maaf, data yang Anda cari tidak tersedia. Silakan coba dengan pencarian lain.",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 18.0, color: widget.colorPalette.black),
        ),
      ),
    );
  }

  Widget tableWidget(
      BuildContext context, Map<String, List<ThirdPartyLoan>> companies) {
    final filteredCompanies = companies.map((k, v) {
      try {
        return MapEntry(
            k,
            v.firstWhere((a) =>
                a.tahun.toString() == currentTahun && a.getNumber() > 0));
      } catch (ex) {
        return MapEntry(k, null);
      }
    }).sortBasedOnValue();
    return CustomTable(
      colorPalette: widget.colorPalette,
      data: filteredCompanies,
      headers: [
        TableText(text: "Nama Perusahaan", flexColumnWidth: 100),
        TableText(
            text: "Jumlah Pinjaman",
            type: TableTextType.NUMBER,
            flexColumnWidth: 50),
      ],
      rowDescriptor: (key, ThirdPartyLoan value) => TableRow(children: [
        cell(
          text: widget.store.getNamaPendek(key),
        ),
        cell(
            text: value.jumlah == null
                ? "-"
                : formatNumber(value.getNumber() / Constants.million),
            textAlign: TextAlign.end),
      ]),
      total: filteredCompanies.values
          .fold(0, (a, b) => a + (b?.getNumber() ?? 0) / Constants.million),
    );
  }

  Widget companyList(
      BuildContext context, Map<String, List<ThirdPartyLoan>> companies) {
    if (companies != null && companies.isEmpty)
      return queryNotFoundError(context);

    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: tableWidget(context, companies),
    );
  }

  Widget filterWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: FilterWidget(
        width: 100,
        title: "Tahun Periode",
        currentItem: currentTahun,
        items: tahunList,
        onChanged: (wamen) {
          setState(() {
            currentTahun = wamen;
          });
        },
      ),
    );
  }

  Widget mainWidget(BuildContext context) {
    return loan == null && _searchController.text.isEmpty
        ? isError
            ? CustomErrorWidget(
                onRetry: () => getData(),
              )
            : LoadingWidget(
                colorPalette: widget.colorPalette,
              )
        : ListView(padding: const EdgeInsets.all(16.0), children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                filterWidget(context),
                Expanded(
                  child: searchBar(context),
                )
              ],
            ),
            companyList(
                context,
                _searchController.text.isNotEmpty
                    ? filteredThirdPartyLoan
                    : loan)
          ]);
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      title: "Third Party Loan",
      body: (ctx) => mainWidget(context),
    );
  }
}
