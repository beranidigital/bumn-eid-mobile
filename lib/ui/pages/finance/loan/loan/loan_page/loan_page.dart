import 'package:after_layout/after_layout.dart';
import 'package:bumn_eid/core/controllers/finance_controller.dart';
import 'package:bumn_eid/core/di/injectable_widget.dart';
import 'package:bumn_eid/core/models/finance/loan.dart';
import 'package:bumn_eid/core/redux/states/app_state/app_state.dart';
import 'package:bumn_eid/core/utils/constants.dart';
import 'package:bumn_eid/irwan_dev/services/api_statistic.dart';
import 'package:bumn_eid/ui/components/base_scaffold.dart';
import 'package:bumn_eid/ui/components/custom_error_widget.dart';
import 'package:bumn_eid/ui/components/filter_widget.dart';
import 'package:bumn_eid/ui/components/loading_widget.dart';
import 'package:bumn_eid/ui/components/search_bar.dart';
import 'package:bumn_eid/ui/components/single_list_view.dart';
import 'package:bumn_eid/ui/components/sum_type_text.dart';
import 'package:bumn_eid/ui/pages/finance/loan/loan/loan_page/di/loan_page_graph.dart';
import 'package:bumn_eid/ui/pages/finance/loan/loan/loan_page/loan_action_mapper.dart';
import 'package:bumn_eid/ui/utils/color_palette.dart';
import 'package:bumn_eid/ui/utils/widget_utils.dart';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';

class LoanPageModel with SingleListItem {
  final String id;
  final String namaPerusahaan;
  final num total;

  LoanPageModel(
      {@required this.id, @required this.namaPerusahaan, @required this.total});

  @override
  String getTitle() {
    return namaPerusahaan;
  }
}

// ignore: must_be_immutable
class LoanPage extends StatefulWidget with InjectableWidget {
  final LoanPageGraph _graph;

  //injected
  ColorPalette colorPalette;
  //injected
  LoanActionMapper actionMapper;
  //injected
  FinanceController financeController;
  //injected
  Store<AppState> store;

  @override
  LoanPageGraph graph() => _graph;

  LoanPage([graph]) : this._graph = graph ?? LoanPageGraph() {
    setup();
  }

  @override
  _LoanPageState createState() => _LoanPageState();
}

class _LoanPageState extends State<LoanPage> with AfterLayoutMixin<LoanPage> {
  bool isError = false;

  String currentTahun = "2019";
  List<String> tahunList = ["2017", "2018", "2019"];
  Map<String, List<Loan>> loan;
  Map<String, List<Loan>> filteredLoan;
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
      Map<String, List<Loan>> data = {};
      List<Loan> companies = await widget.financeController.fetchLoan();

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
    if (Loan == null) return;
    Map<String, List<Loan>> filtered = {};
    final filteredKeys = loan.keys.where((key) {
      return key.toLowerCase().contains(query.toLowerCase());
    }).toList();
    filteredKeys.forEach((key) {
      filtered[key] = loan[key];
    });

    setState(() {
      this.filteredLoan = filtered;
    });
  }

  Widget searchBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: SearchBar(
          colorPalette: widget.colorPalette,
          controller: _searchController,
          onChanged: (query) => filterCompany(query),
          labelText: "Cari perusahaan disini",
          hintText: "Masukkan nama perusahaan."),
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

  Widget tableWidget(BuildContext context, Map<String, List<Loan>> companies) {
    final filteredCompanies = companies.map((k, v) {
      try {
        return MapEntry(
            k, v.firstWhere((a) => a.tahun.toString() == currentTahun));
      } catch (ex) {
        return MapEntry(k, null);
      }
    }).sortBasedOnValue();

    final List<LoanPageModel> convertedData = [];
    filteredCompanies.values.forEach((datum) {
      if (datum != null)
        convertedData.add(LoanPageModel(
            id: datum.companyId,
            namaPerusahaan: widget.store.getNamaPendek(datum.namaPerusahaan),
            total: parseDouble(datum.jumlah) / Constants.million));
    });

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text(
              "* Jumlah dalam triliun rupiah",
              style: TextStyle(
                fontSize: 16.0,
              ),
            ),
          ),
          SingleListView<LoanPageModel>(
            colorPalette: widget.colorPalette,
            onItemTap: (LoanPageModel item) {
              ApiStatistic().insertStatistic(
                  "Finance", "Detail Debt Company ${item.namaPerusahaan} Debt");
              widget.actionMapper.openCompanyDetailPage(item.id);
            },
            items: convertedData,
            leadingWidget: (LoanPageModel item) => SumTypeText(
              colorPalette: widget.colorPalette,
              sum: item.total,
            ),
          ),
        ],
      ),
    );
  }

  Widget companyList(BuildContext context, Map<String, List<Loan>> companies) {
    if (companies != null && companies.isEmpty)
      return queryNotFoundError(context);

    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: tableWidget(context, companies),
    );
  }

  Widget filterWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
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
        : Container(
            color: widget.colorPalette.defaultBg,
            child: ListView(padding: const EdgeInsets.all(16.0), children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Expanded(
                    child: searchBar(context),
                  ),
                  filterWidget(context),
                ],
              ),
              companyList(context,
                  _searchController.text.isNotEmpty ? filteredLoan : loan)
            ]),
          );
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      title: 'Detail Debt',
      body: (ctx) => mainWidget(context),
    );
  }
}
