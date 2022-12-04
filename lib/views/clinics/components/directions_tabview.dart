import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';

class DirectionsTabView extends StatefulWidget {
  DirectionsTabView({Key? key}) : super(key: key);

  @override
  State<DirectionsTabView> createState() => _DirectionsTabViewState();
}

class _DirectionsTabViewState extends State<DirectionsTabView> {
  final Completer<GoogleMapController> _controller = Completer();
  static final LatLng _KMapCenter = LatLng(-1.2921, 36.8219);
  static final CameraPosition _KInitialPosition =
      CameraPosition(target: _KMapCenter, zoom: 15.0, tilt: 0, bearing: 0);

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>{
        Factory<OneSequenceGestureRecognizer>(
          () => EagerGestureRecognizer(),
        ),
      },
      initialCameraPosition: _KInitialPosition,
      onMapCreated: (GoogleMapController controller) {
        _controller.complete(controller);
      },
      mapType: MapType.normal,
      myLocationEnabled: true,
    );
  }
}
