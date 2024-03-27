import 'package:bumn_eid/core/navigation/navigation_destinations.dart';
import 'package:bumn_eid/core/redux/action_mapper.dart';
import 'package:bumn_eid/core/redux/actions/navigation/navigation_actions.dart';
import 'package:bumn_eid/core/redux/states/app_state/app_state.dart';
import 'package:bumn_eid/ui/pages/csr/common/penyebaran_wilayah_page/penyebaran_wilayah_page.dart';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';

class PenyebaranWilayahActionMapper extends ActionMapper {

  PenyebaranWilayahActionMapper(Store<AppState> store) : super(store);

  _featureNotAvailable() => dispatch(ShowDialogAction(destination: FeatureNotAvailableDialogDestination()));

  openDetailedPage({@required PenyebaranWilayahType type, @required int tahun, @required String provinsi})
        => dispatch(NavigateToNextAction(destination: PenyebaranWilayahDetailedPageDestination(
          type: type,
          tahun: tahun,
          provinsi: provinsi
        )));

}