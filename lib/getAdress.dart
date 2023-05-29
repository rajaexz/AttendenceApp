import 'dart:convert';

import 'package:location/location.dart' as loc;
import 'package:geocoding/geocoding.dart' as geo;
import 'package:shared_preferences/shared_preferences.dart';

List<int> cityItemsData = [];
List<int> stateItemsData = [];
List<int> langItemsData = [];
List<int> selectedTempCityId = [];
List<int> selectedTempLangId = [];

String pincode = '';
Map currentLocation = {};
int selectedCityId = -1;
loc.Location location = loc.Location();
// ignore: prefer_typing_uninitialized_variables
late loc.PermissionStatus _permissionGranted;
var first;

_getLocPermissionGranted() async {
  _permissionGranted = await location.hasPermission();
  if (_permissionGranted == loc.PermissionStatus.denied) {
    _permissionGranted = await location.requestPermission();
    if (_permissionGranted != loc.PermissionStatus.granted) {
      return;
    }
  }
}

getLocation() async {
  late List lastLocation = [];
  late loc.LocationData _locationData;
  bool _isLocationOn = await location.serviceEnabled();
  final _pref = await SharedPreferences.getInstance();

  var lastLocationString = _pref.getString('currentLocation');
  if (lastLocationString != null && lastLocationString != 'null') {
    lastLocation = [jsonDecode(lastLocationString)];
  } else {
    await _pref.setString('currentLocation', '{}');
  }

  if (_isLocationOn) {
    _getLocPermissionGranted();

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
  } else {
    if (lastLocation.isEmpty) {
      _isLocationOn = await location.requestService();

      if (_isLocationOn) _getLocPermissionGranted();

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
    } else {
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
