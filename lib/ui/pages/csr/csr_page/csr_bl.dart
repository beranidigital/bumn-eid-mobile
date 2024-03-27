import 'package:bumn_eid/core/controllers/csr_controller.dart';
import 'package:bumn_eid/core/models/csr/csr_company.dart';
import 'package:bumn_eid/core/navigation/navigation_destinations.dart';
import 'package:bumn_eid/core/redux/actions/navigation/navigation_actions.dart';
import 'package:bumn_eid/core/redux/states/app_state/app_state.dart';
import 'package:bumn_eid/irwan_dev/services/api_statistic.dart';
import 'package:bumn_eid/ui/components/base_card.dart';
import 'package:bumn_eid/ui/components/loadable_widget.dart';
import 'package:bumn_eid/ui/utils/color_palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

class CsrBL extends StatelessWidget {
  final CsrController csrController;

  CsrBL({
    @required this.csrController,
  });

  @override
  Widget build(BuildContext context) {
    return LoadableWidget(
      fetchFunction: () async {
        return csrController.fetchBlCompanies();
      },
      colorPalette: ColorPalette(),
      buildFunction: (ctx, generalData) {
        final List<CsrCompany> items = generalData;
        return InkWell(
          onTap: () {
            ApiStatistic().insertStatistic("CSR", "Level 2 Bina Lingkungan");
            StoreProvider.of<AppState>(context).dispatch(
              NavigateToNextAction(
                destination: BinaLingkunganPageDestination(),
              ),
            );
          },
          child: BaseCard(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      'res/images/csr_bl.png',
                      height: 32.0,
                    ),
                    SizedBox(
                      width: 8.0,
                    ),
                    Text(
                      'Bina Lingkungan',
                      style: TextStyle(
                        fontFamily: 'poppins',
                        fontSize: 16.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Spacer(),
                    Text(
                      'Selengkapnya>>',
                      style: TextStyle(
                        fontFamily: 'poppins',
                        fontWeight: FontWeight.w500,
                        fontSize: 11.0,
                        color: Color(0xFF1FA4CA),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 16.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          border: Border.all(
                            color: Color(0xFF1FA4CA),
                          ),
                        ),
                        padding: EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Total Mitra',
                              style: TextStyle(
                                fontFamily: 'poppins',
                                fontWeight: FontWeight.w500,
                                fontSize: 12.0,
                              ),
                            ),
                            Expanded(
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  items.length.toString(),
                                  style: TextStyle(
                                    fontFamily: 'poppins',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16.0,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
