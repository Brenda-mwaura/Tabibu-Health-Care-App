import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:location/location.dart' as location_package;
import 'package:tabibu/providers/clinic_provider.dart';

class GeolocationProvider with ChangeNotifier {
  var _longitude = 0.0;
  var _latitude = 0.0;
  bool _onGeolocationLoading = false;
  bool _onGeolocationError = false;

  late StreamSubscription<Position> streamSubscription;
  double? get longitude => _longitude;
  double? get latitude => _latitude;

  bool get onGeolocationLoading => _onGeolocationLoading;
  bool get onGeolocationError => _onGeolocationError;

  Future getLocation() async {
    try {
      _onGeolocationLoading = true;
      bool serviceEnabled;
      LocationPermission permission;
      serviceEnabled = await Geolocator.isLocationServiceEnabled();

      if (!serviceEnabled) {
        await Geolocator.openLocationSettings();
        return Future.error("Location services are disabled.");
      }

      permission = await Geolocator.checkPermission();
      if (permission == PermissionStatus.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == PermissionStatus.denied) {
          return Future.error("Location permissions are denied");
        }
      }
      if (permission == LocationPermission.deniedForever) {
        return Future.error(
            "Location permissions are permanently denied, we cannot request permissions.");
      }
      streamSubscription = Geolocator.getPositionStream().listen((
        Position position,
      ) async {
        print(position == null
            ? 'Unknown'
            : '${position.latitude}, ${position.longitude}');
        _latitude = position.latitude;
        _longitude = position.longitude;

        await getAddressFromLatLng(_latitude, _longitude);
        await clinicProvider.fetchNearestClinics(_latitude, _longitude);
      });
      _onGeolocationLoading = false;
      notifyListeners();
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
