import 'package:bumn_eid/core/models/business_portfolio/profil_perusahaan.dart';
import 'package:flutter/material.dart';

class GotCompaniesAction {
  final List<ProfilPerusahaan> companies;

  GotCompaniesAction({@required this.companies});
}

class ResetCompaniesAction {}

class FilterTotalCompaniesAction {
  final String query;

  FilterTotalCompaniesAction({@required this.query});
}