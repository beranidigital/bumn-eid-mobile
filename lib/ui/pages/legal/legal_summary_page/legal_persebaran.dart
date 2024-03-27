import 'package:bumn_eid/core/models/legal/legal_summary_data.dart';
import 'package:bumn_eid/core/utils/constants.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LegalPersebaran extends StatefulWidget {
  final LegalSummaryData data;

  LegalPersebaran({
    @required this.data,
  });

  @override
  _LegalPersebaranState createState() => _LegalPersebaranState();
}

class _LegalPersebaranState extends State<LegalPersebaran> {
  @override
  Widget build(BuildContext context) {
    Map<String, int> data = {};
    final sortedData = widget.data.summary_kota;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(
          color: Color(0xFF1FA4CA),
          width: 2.0,
        ),
      ),
      padding: EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Persebaran Perkara',
            style: TextStyle(
              fontFamily: 'poppins',
              fontWeight: FontWeight.w600,
              fontSize: 12.0,
            ),
          ),
          SizedBox(
            height: 16.0,
          ),
          mapWidget(context),
        ],
      ),
    );
  }

  Widget mapWidget(BuildContext context) {
    return Container(
      height: 180.0,
      margin: EdgeInsets.symmetric(
        horizontal: 12.0,
      ),
      child: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: Constants.indonesiaCameraPositionMarker,
          zoom: 3.2046,
        ),
        markers: widget.data.summary_kota
            .map((item) => Marker(
                  markerId: MarkerId(item.kota),
                  position: Constants.mapToLat.containsKey(item.kota)
                      ? Constants.mapToLat[item.kota]
                      : Constants.indonesiaCameraPositionMarker,
                  infoWindow: InfoWindow(
                    title: item.kota,
                    snippet: "Jumlah: ${item.total_kasus} Kasus",
                  ),
                ))
            .toSet(),
        gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>[
          new Factory<OneSequenceGestureRecognizer>(
            () => new EagerGestureRecognizer(),
          ),
        ].toSet(),
      ),
    );
  }
}
