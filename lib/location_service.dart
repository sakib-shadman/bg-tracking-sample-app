import 'package:location/location.dart';

abstract class LocationBase {
  Future<LocationData?> currentLocation();
}

class LocationService implements LocationBase {
  final location = Location();

  @override
  Future<LocationData?> currentLocation() async {
    if (await isLocationServiceEnabled() &&
        await isLocationPermissionGranted()) {
      return location.getLocation();
    } else {
      return null;
    }
  }

  Future<bool> isLocationServiceEnabled() async {
    bool _serviceEnabled;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return false;
      }
    }

    return _serviceEnabled;
  }

  Future<bool> isLocationPermissionGranted() async {
    PermissionStatus _isPermissionGranted;

    _isPermissionGranted = await location.hasPermission();
    if (PermissionStatus.granted != _isPermissionGranted) {
      _isPermissionGranted = await location.requestPermission();
      if (PermissionStatus.granted != _isPermissionGranted) {
        return false;
      }
    }

    return _isPermissionGranted == PermissionStatus.granted;
  }
}
