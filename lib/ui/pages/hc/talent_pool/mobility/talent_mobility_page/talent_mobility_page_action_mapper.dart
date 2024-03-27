import 'package:bumn_eid/core/models/hc/talent_pool_item.dart';
import 'package:bumn_eid/core/navigation/navigation_destinations.dart';
import 'package:bumn_eid/core/redux/action_mapper.dart';
import 'package:bumn_eid/core/redux/actions/navigation/navigation_actions.dart';
import 'package:bumn_eid/core/redux/states/app_state/app_state.dart';
import 'package:redux/redux.dart';

class TalentMobilityPageActionMapper extends ActionMapper {

  TalentMobilityPageActionMapper(Store<AppState> store) : super(store);

  _featureNotAvailable() => dispatch(ShowDialogAction(destination: FeatureNotAvailableDialogDestination()));

  goToDetail(TalentPoolItem talentPoolItem) => dispatch(
    NavigateToNextAction(
      destination: TalentPoolDetailPageDestination(
        profile: talentPoolItem
      )
    )
  );

}