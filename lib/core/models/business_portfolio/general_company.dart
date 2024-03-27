import 'package:bumn_eid/ui/components/single_list_view.dart';

mixin GeneralCompany implements SingleListItem {
  String getId();
  String getName();
  String getShortName();
  String getCluster();
  String getWamen();
  String getKelas();

  @override
  String getTitle() {
    return getName();
  }
}