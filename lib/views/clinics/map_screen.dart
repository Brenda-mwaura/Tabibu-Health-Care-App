import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final Completer<GoogleMapController> _controller = Completer();
  static final LatLng _KMapCenter = LatLng(-1.2921, 36.8219);
  static final CameraPosition _KInitialPosition =
      CameraPosition(target: _KMapCenter, zoom: 15.0, tilt: 0, bearing: 0);

  final Map clinics = {
    "results": [
      {
        "id": 1,
        "clinic_name": "Mama Lucy Hospital",
        "location": "Nairobi",
        "lat": -1.2921,
        "lng": 36.8219,
        "phone": "+254 712 345 678",
        "email": "mamalucy@gmail.com",
        "open": true
      },
      {
        "id": 2,
        "clinic_name": "Jomo Kenyatta Hospital",
        "location": "Kiambu",
        "lat": -1.2835,
        "lng": 36.8236,
        "phone": "+254 712 345 678",
        "email": "jomo@gmail.com",
        "open": false
      },
      {
        "id": 3,
        "clinic_name": "Moi Teaching and Referral Hospital",
        "location": "Nairobi",
        "lat": -1.2933,
        "lng": 36.8243,
        "phone": "+254 712 345 678",
        "email": "moi@gmail.com",
        "open": false
      },
      {
        "id": 4,
        "clinic_name": "Aga Khan Hospital",
        "location": "Nairobi",
        "lat": -1.1921,
        "lng": 36.4219,
        "phone": "+254 712 345 678",
        "email": "aga@gmail.com",
        "open": true
      },
      {
        "id": 5,
        "clinic_name": "Kenya Medical Training College",
        "location": "Nairobi",
        "lat": -1.2521,
        "lng": 36.7219,
        "phone": "+254 712 345 678",
        "email": "kmtc@gmail.com",
        "open": false
      }
    ],
  };
  BitmapDescriptor pinLocationIcon = BitmapDescriptor.defaultMarker;
  @override
  void initState() {
    _setClinicMarker();
    super.initState();
  }

  void _setClinicMarker() async {
    pinLocationIcon = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(
          // devicePixelRatio: 2.5,
          size: Size(20, 20),
        ),
        'assets/images/marker.png');
  }

  // create a marker with the image of the clinic
  Set<Marker> _createMarker() {
    return clinics["results"]
        .map<Marker>(
          (clinic) =>
              //create a marker with the image from asset/images/clinic.png

              Marker(
            markerId: MarkerId(clinic["id"].toString()),
            position: LatLng(clinic["lat"], clinic["lng"]),
            infoWindow: InfoWindow(
              title: clinic["clinic_name"],
              snippet: clinic["location"],
            ),
            draggable: true,
            // create marker
            icon: pinLocationIcon,
            // pinLocationIcon,
            // BitmapDescriptor.defaultMarkerWithHue(
            //   BitmapDescriptor.hueViolet,
            // ),
          ),
        )
        .toSet();
  }

  // // onMap created
  // void _onMapCreated(GoogleMapController controller) {
  //   _controller.complete(controller);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GoogleMap(
          initialCameraPosition: _KInitialPosition,
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
          markers: _createMarker(),
          mapType: MapType.normal,
          myLocationEnabled: true,
        ),
      ),
    );
  }
}
