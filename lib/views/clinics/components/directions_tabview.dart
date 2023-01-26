import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'dart:ui' as ui;
import 'package:provider/provider.dart';
import 'package:tabibu/data/models/clinic_model.dart';
import 'package:tabibu/providers/clinic_provider.dart';
import 'package:tabibu/providers/geolocation_provider.dart.dart';
import 'package:tabibu/widgets/spinner.dart';

class DirectionsTabView extends StatefulWidget {
  final Clinic clinic;
  DirectionsTabView({Key? key, required this.clinic}) : super(key: key);

  @override
  State<DirectionsTabView> createState() => _DirectionsTabViewState();
}

class _DirectionsTabViewState extends State<DirectionsTabView> {
  final Completer<GoogleMapController> _controller = Completer();
  LatLng _KMapCenter = LatLng(-1.2921, 36.8219);

  BitmapDescriptor pinLocationIcon = BitmapDescriptor.defaultMarker;

  @override
  void initState() {
    _setClinicMarker();
    super.initState();
    _refresh();
  }

  Future<void> _refresh() async {
    var locationProvider =
        Provider.of<GeolocationProvider>(context, listen: false);
    await locationProvider.getLocation();
    _KMapCenter = LatLng(widget.clinic.latitude!.toDouble(),
        widget.clinic.longitude!.toDouble());
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
        await getBytesFromAsset('assets/images/marker.png', 140);
    pinLocationIcon = BitmapDescriptor.fromBytes(markerIcon);
  }

  final CustomInfoWindowController _customInfoWindowController =
      CustomInfoWindowController();

  @override
  Widget build(BuildContext context) {
    Set<Marker> createMarker() {
      return <Marker>{
        Marker(
          markerId: MarkerId(widget.clinic.id.toString()),
          position: LatLng(widget.clinic.latitude!.toDouble(),
              widget.clinic.longitude!.toDouble()),
          infoWindow: InfoWindow(
            title: widget.clinic.clinicName,
            snippet: widget.clinic.address,
          ),
          icon: pinLocationIcon,
        ),
      };
    }

    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: _refresh,
          child: Consumer<GeolocationProvider>(
            builder: (context, value, child) {
              if (value.onGeolocationLoading == true) {
                return const Center(child: AppSpinner());
              } else if (value.onGeolocationLoading == false) {
                return GoogleMap(
                  initialCameraPosition: CameraPosition(
                      target: _KMapCenter, zoom: 15.0, tilt: 0, bearing: 0),
                  myLocationEnabled: true,
                  myLocationButtonEnabled: true,
                  mapToolbarEnabled: true,
                  compassEnabled: true,
                  onMapCreated: (GoogleMapController controller) async {
                    _controller.complete(controller);
                    _customInfoWindowController.googleMapController =
                        controller;
                  },
                  markers: createMarker(),
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
