import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:location/location.dart' as location_package;
import 'package:tabibu/providers/clinic_provider.dart';

import '../configs/styles.dart';

class GeolocationProvider with ChangeNotifier {
  double _longitude = 0.0;
  double _latitude = 0.0;
  bool _onGeolocationLoading = false;
  bool _onGeolocationError = false;

  late StreamSubscription<Position> streamSubscription;
  double? get longitude => _longitude;
  double? get latitude => _latitude;

  bool get onGeolocationLoading => _onGeolocationLoading;
  bool get onGeolocationError => _onGeolocationError;

  void _locationPermissionToast() {
    Fluttertoast.showToast(
      msg:
          "We're sorry, but we're unable to access your location as the app's location permission has been denied. Please allow location permission for our app in your device's settings to use this feature.",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 4,
      backgroundColor: Styles.primaryColor,
      textColor: Colors.white,
      fontSize: 18.0,
    );
  }

  Future getLocation() async {
    try {
      _onGeolocationLoading = true;
      LocationPermission permission;
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();

      if (!serviceEnabled) {
        await Geolocator.openLocationSettings();
        return Future.error("Location services are disabled.");
      }

      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission=await Geolocator.requestPermission();
        _locationPermissionToast();
        if (permission == LocationPermission.denied ||
            permission == LocationPermission.deniedForever) {
          return Future.error("Location permissions are denied");
        }
      }
      if (permission == LocationPermission.deniedForever) {
        return Future.error(
            "Location permissions are permanently denied, we cannot request permissions.");
      }

      await Geolocator.getCurrentPosition(
              desiredAccuracy: LocationAccuracy.high)
          .then((Position position) async {
        print(position == null
            ? 'Unknown'
            : 'Lat: ${position.latitude}, Long: ${position.longitude}');
        _latitude = position.latitude;
        _longitude = position.longitude;

        await getAddressFromLatLng(_latitude, _longitude);
        await clinicProvider.fetchNearestClinics(_latitude, _longitude);
      });
   
      notifyListeners();
      _onGeolocationLoading = false;
    } catch (e) {
      _onGeolocationError = false;
    }
  }

  String? _address;
  String? get address => _address;

  Future<void> getAddressFromLatLng(latitude, longitude) async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(latitude, longitude);
    Placemark place = placemarks[0];
    // print(place);
    _address = //if place sublocality is null
        place.subLocality == null
            ? '${place.locality}'
            : '${place.locality}, ${place.subLocality}';
    // print("Current locality::: $_address");
    notifyListeners();
  }
}

GeolocationProvider geolocationProvider = GeolocationProvider();
