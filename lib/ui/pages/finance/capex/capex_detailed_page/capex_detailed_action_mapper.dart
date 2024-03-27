import 'package:bumn_eid/core/models/business_portfolio/profil_perusahaan.dart';
import 'package:bumn_eid/core/navigation/navigation_destinations.dart';
import 'package:bumn_eid/core/redux/action_mapper.dart';
import 'package:bumn_eid/core/redux/actions/navigation/navigation_actions.dart';
import 'package:bumn_eid/core/redux/states/app_state/app_state.dart';
import 'package:redux/redux.dart';

class CapexDetailedActionMapper extends ActionMapper {

  CapexDetailedActionMapper(Store<AppState> store) : super(store);

  openCompanyDetailPage(String companyId)
  {
    dispatch(NavigateToNextAction(
        destination: CompanyDetailPageDestination(
            id: companyId
        )
    ));
  }

}