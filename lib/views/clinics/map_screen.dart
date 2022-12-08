import 'dart:async';

import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:tabibu/providers/geolocation_provider.dart.dart';
import 'package:tabibu/widgets/app_drawer.dart';
import 'package:tabibu/widgets/spinner.dart';
import 'dart:ui' as ui;

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
    _refresh();
    _setClinicMarker();
    super.initState();
  }

  Future<void> _refresh() async {
    var locationService =
        Provider.of<GeolocationProvider>(context, listen: false);
    await locationService.getLocation();
    _KMapCenter = LatLng(locationService.latitude!, locationService.longitude!);
  }

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  Future<void> _setClinicMarker() async {
    final Uint8List markerIcon =
        await getBytesFromAsset('assets/images/marker.png', 100);
    pinLocationIcon = BitmapDescriptor.fromBytes(markerIcon);
  }

  final Map _clinics = {
    "Annex clinic": {"lat": -1.2921, "long": 36.8219},
    "Mama Lucy": {"lat": -1.2921, "long": 36.8249},
    "Google Plex": {"lat": 37.4219999, "long": -122.0872462},
  };
  CustomInfoWindowController _customInfoWindowController =
      CustomInfoWindowController();

  Set<Marker> _createMarker() {
    return _clinics.entries
        .map(
          (e) => Marker(
              markerId: MarkerId(e.key),
              position: LatLng(e.value["lat"], e.value["long"]),
              icon: pinLocationIcon,
              infoWindow: InfoWindow(
                title: e.key,
                snippet: "Tap to view clinic details",
              ),
              onTap: () {
                print("Hello...");
                CustomInfoWindow(
                  controller: _customInfoWindowController,
                  height: 100,
                  width: 200,
                  offset: 35,
                );
              }),
        )
        .toSet();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: _refresh,
          child: Consumer<GeolocationProvider>(
            builder: (context, value, child) {
              if (value.onGeolocationLoading == true) {
                return AppSpinner();
              } else if (value.onGeolocationLoading == false) {
                return GoogleMap(
                  initialCameraPosition: CameraPosition(
                      target: _KMapCenter, zoom: 15.0, tilt: 0, bearing: 0),
                  myLocationEnabled: true,
                  myLocationButtonEnabled: true,
                  mapToolbarEnabled: true,
                  compassEnabled: true,
                  onMapCreated: (GoogleMapController controller) {
                    _controller.complete(controller);
                    _customInfoWindowController.googleMapController =
                        controller;
                  },
                  markers: _createMarker(),
                  mapType: MapType.normal,
                  onTap: (position) {},
                );
              } else {
                return const Center(
                  child: Text("We can't reach your location"),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
