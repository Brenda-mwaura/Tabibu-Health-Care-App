import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:tabibu/providers/geolocation_provider.dart.dart';
import 'package:tabibu/widgets/app_drawer.dart';
import 'package:tabibu/widgets/spinner.dart';

class MapScreen extends StatefulWidget {
  MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final Completer<GoogleMapController> _controller = Completer();
  LatLng _KMapCenter = LatLng(-1.2921, 36.8219);

  BitmapDescriptor pinLocationIcon = BitmapDescriptor.defaultMarker;
  @override
  void initState() {
    _setClinicMarker();
    super.initState();
    _refresh();
  }

  void _refresh() async {
    var locationService =
        Provider.of<GeolocationProvider>(context, listen: false);
    await locationService.getLocation();
    _KMapCenter = LatLng(locationService.latitude!, locationService.longitude!);
  }

  void _setClinicMarker() async {
    pinLocationIcon = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(
          // devicePixelRatio: 2.5,
          size: Size(20, 20),
        ),
        'assets/images/marker.png');
  }

  // // create a marker with the image of the clinic
  // Set<Marker> _createMarker() {
  //   return clinics["results"]
  //       .map<Marker>(
  //         (clinic) =>
  //             //create a marker with the image from asset/images/clinic.png

  //             Marker(
  //           markerId: MarkerId(clinic["id"].toString()),
  //           position: LatLng(clinic["lat"], clinic["lng"]),
  //           infoWindow: InfoWindow(
  //             title: clinic["clinic_name"],
  //             snippet: clinic["location"],
  //           ),
  //           draggable: true,

  //           // icon: pinLocationIcon,
  //           icon: BitmapDescriptor.defaultMarkerWithHue(
  //             BitmapDescriptor.hueViolet,
  //           ),
  //         ),
  //       )
  //       .toSet();
  // }

  // // onMap created
  // void _onMapCreated(GoogleMapController controller) {
  //   _controller.complete(controller);
  // }
  // mylocation button
  // void _myLocation() async {
  //   final GoogleMapController controller = await _controller.future;
  //   controller.animateCamera(CameraUpdate.newCameraPosition(_KInitialPosition));
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Consumer<GeolocationProvider>(
          builder: (context, value, child) {
            if (value.onGeolocationLoading == true) {
              return AppSpinner();
            } else if (value.onGeolocationLoading == false) {
              return GoogleMap(
                initialCameraPosition: CameraPosition(
                    target: _KMapCenter,
                    // LatLng(value.latitude!, value.longitude!),
                    zoom: 15.0,
                    tilt: 0,
                    bearing: 0),
                myLocationEnabled: true,
                myLocationButtonEnabled: true,
                mapToolbarEnabled: true,
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                },
                // markers: _createMarker(),
                mapType: MapType.normal,
              );
            } else {
              return const Center(
                child: Text("We can't reach your location"),
              );
            }
          },
        ),
      ),
    );
  }
}
