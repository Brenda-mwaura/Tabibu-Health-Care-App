import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:location/location.dart' as location_package;
import 'package:tabibu/providers/clinic_provider.dart';

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

  Future getLocation() async {
    try {
      _onGeolocationLoading = true;
      bool serviceEnabled;
      LocationPermission permission;
      serviceEnabled = await Geolocator.isLocationServiceEnabled();

      final LocationSettings locationSettings = LocationSettings(
        accuracy: LocationAccuracy.high,
        timeLimit: Duration(seconds: 30),
      );

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
      // .getPositionStream(locationSettings: locationSettings).
      //     .listen((
      //   Position position,
      // ) async {
      //   print(position == null
      //       ? 'Unknown'
      //       : 'Lat: ${position.latitude}, Long: ${position.longitude}');
      //   _latitude = position.latitude;
      //   _longitude = position.longitude;
      //   await getAddressFromLatLng(_latitude, _longitude);
      //   await clinicProvider.fetchNearestClinics(_latitude, _longitude);
      // });

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


//     final url = 'https://maps.googleapis.com/maps/api/directions/json?origin=${origin.latitude},${origin.longitude}&destination=${destination.latitude},${destination.longitude}&mode=driving&key=YOUR_API_KEY';
//     final response = await http.get(url);
//     final decodedResponse = jsonDecode(response.body);
//     final timeInSeconds = decodedResponse['routes'][0]['legs'][0]['duration']['value'];
//     final timeInMinutes = timeInSeconds / 60;
//     return timeInMinutes;
// }
// The above function takes two LatLng objects as input, origin and destination, and returns the estimated travel time in minutes.
// The example above uses the Google Maps Directions API, which requires an API key. You can sign up for a free API key from the Google Cloud Console.

// Make sure to also import the package and add the required dependencies in your pubspec.yaml file.

// You can also use other services like Open Street Map and Mapbox to calculate the directions between two cordinates.




