import 'package:bumn_eid/core/models/hc/talent_pool_item.dart';
import 'package:bumn_eid/core/navigation/navigation_destinations.dart';
import 'package:bumn_eid/core/redux/action_mapper.dart';
import 'package:bumn_eid/core/redux/actions/navigation/navigation_actions.dart';
import 'package:bumn_eid/core/redux/states/app_state/app_state.dart';
import 'package:bumn_eid/ui/pages/hc/bod/bod_potret_tugas_page/potret_talent_detail_page/potret_talent_detail_page.dart';
import 'package:redux/redux.dart';

class SearchPeoplePageActionMapper extends ActionMapper {

  SearchPeoplePageActionMapper(Store<AppState> store) : super(store);

  _featureNotAvailable() => dispatch(ShowDialogAction(destination: FeatureNotAvailableDialogDestination()));

  goToDetailInduk(int id) => dispatch(
    NavigateToNextAction(
      destination: PotretTugasBODTalentPageDestination(
        id: id,
        isBod: false,
        now: true,
        withCv: true,
      )
    )
  );

  goToDetailAnak(int id) => dispatch(
      NavigateToNextAction(
          destination: DekomAnakTalentDetailPageDestination(
            id: id
          )
      )
  );

  goToDetailCucu(int id) => dispatch(
      NavigateToNextAction(
          destination: DekomCucuTalentDetailPageDestination(
              id: id
          )
      )
  );

}