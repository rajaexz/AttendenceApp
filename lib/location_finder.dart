import 'dart:convert';

import 'package:location/location.dart' as loc;
import 'package:geocoding/geocoding.dart' as geo;
import 'package:shared_preferences/shared_preferences.dart';
import 'getAdress.dart';
loc.Location location = loc.Location();
var first;

getLocPermissionGranted() async {
  var _permissionGranted = await location.hasPermission();

    print(_permissionGranted);
  // ignore: unnecessary_null_comparison
  if (_permissionGranted != null &&
      _permissionGranted != loc.PermissionStatus.denied &&
      _permissionGranted != loc.PermissionStatus.deniedForever) {
    return _permissionGranted;
  } else {
    print('elase condition');
    _permissionGranted = await location.requestPermission();
    print('request permission ==== $_permissionGranted');
    return _permissionGranted;
  }
}

getLocationAlertResponse() async {
  bool _isLocationOn = await location.requestService();
  return _isLocationOn;
}

getLocation({required String userType}) async {
  late loc.LocationData _locationData;
  final _pref = await SharedPreferences.getInstance();

  if (userType == 'new') {
    _locationData = await location.getLocation();
    String fullAdd =
    await getFullAddress(_locationData.latitude, _locationData.longitude);
    await _pref.setString('currentLocation', jsonEncode(currentLocation));

    return {
      'lat': '${_locationData.latitude}',
      'long': '${_locationData.longitude}',
      'add': fullAdd,
      'city': currentLocation['city'],
      'pincode': first.postalCode
    };
  } else if (userType == 'old') {
    String tempJsonString = '${_pref.getString('currentLocation')}';
    currentLocation = jsonDecode(tempJsonString);
    return {
      'lat': '${currentLocation['lat']}',
      'long': '${currentLocation['long']}',
      'city': currentLocation['city'],
      'add':
      '${currentLocation['city']}, ${currentLocation['state']}, ${currentLocation['pincode']}, ${currentLocation['country']}',
      'pincode': '${currentLocation['pincode']}'
    };
  }
}

Future<String> getFullAddress(lat, long) async {
  List<geo.Placemark> placemarks =
  await geo.placemarkFromCoordinates(lat, long);
  first = placemarks.first;

  //to make available pincode and currentlocation globally
  pincode = '${first.postalCode}';

  currentLocation['pincode'] = pincode;
  currentLocation['city'] = '${first.locality}';
  currentLocation['state'] = '${first.administrativeArea}';
  currentLocation['country'] = '${first.country}';
  currentLocation['lat'] = lat;
  currentLocation['long'] = long;

  String address =
      '${first.street}, ${first.subAdministrativeArea}, ${first.subLocality}, ${first.locality}, ${first.postalCode}, ${first.country}';
  currentLocation['full'] = address;

  return address;
}
