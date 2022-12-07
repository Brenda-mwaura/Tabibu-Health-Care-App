import 'package:flutter/foundation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:location/location.dart' as location_package;

class PermissionProvider with ChangeNotifier {
  PermissionStatus _locationStatus = PermissionStatus.denied;
  LatLng? _locationCenter;
  final location_package.Location _location = location_package.Location();
  location_package.LocationData? _locationData;

  // getters
  get location => _location;
  get locationCenter => _locationCenter as LatLng;
  get locationStatus => _locationStatus;

  Future<PermissionStatus> getLocationStatus() async {
    final status = await Permission.location.request();
    _locationStatus = status;

    print("Location status: $_locationStatus");
    notifyListeners();
    return status;
  }

  Future<void> getLocation() async {
    final status = await getLocationStatus();
    if (status == PermissionStatus.granted ||
        status == PermissionStatus.limited) {
      try {
        _locationData = await _location.getLocation();
        final lat = _locationData != null
            ? _locationData!.latitude as double
            : "Not available";
        final lon = _locationData != null
            ? _locationData!.longitude as double
            : "Not available";

        print("$lat $lon");
        _locationCenter = _locationData as LatLng?;
      } catch (e) {
        _locationCenter = null;
        rethrow;
      }
      notifyListeners();
    }
  }
}

PermissionProvider permissionProvider = PermissionProvider();
