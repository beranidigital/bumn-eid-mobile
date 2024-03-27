import 'package:bumn_eid/core/redux/actions/companies/companies_actions.dart';
import 'package:bumn_eid/core/redux/states/app_state/app_state.dart';
import 'package:bumn_eid/core/redux/states/companies/companies_state.dart';

const Map<Type, Function> companiesReducers = {
  //GotCompaniesAction
  GotCompaniesAction: _gotCompaniesReducer,

  //ResetCompaniesAction
  ResetCompaniesAction: _resetCompaniesReducer,

  //FilterTotalCompaniesAction
  FilterTotalCompaniesAction: _filterTotalCompaniesReducer
};

AppState _gotCompaniesReducer(
    GotCompaniesAction action,
    AppState state,
    ) {
  CompaniesState companiesState =
  state.companiesState.copyWith(companies: action.companies);
  return state.copyWith(
    companiesState: companiesState,
  );
}

AppState _filterTotalCompaniesReducer(
    FilterTotalCompaniesAction action,
    AppState state,
    ) {
  final filtered = state.companiesState.companies.where((company) {
    return company.nama.toLowerCase().contains(action.query.toLowerCase());
  }).toList();

  CompaniesState companiesState =
  state.companiesState.copyWith(filteredTotalCompanies: filtered);
  return state.copyWith(
    companiesState: companiesState,
  );
}

AppState _resetCompaniesReducer(
    ResetCompaniesAction action,
    AppState state,
    ) {
  CompaniesState companiesState = state.companiesState.copyWith(
    companies: []
  );
  return state.copyWith(
    companiesState: companiesState,
  );
}