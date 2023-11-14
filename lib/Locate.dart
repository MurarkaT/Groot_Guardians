import 'package:flutter/material.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'main.dart';
import 'package:kanha1011/HomeManagement.dart';
import 'package:location/location.dart';
class Locate extends StatefulWidget{
  const Locate({Key? key}): super(key: key);

  @override
  State<Locate> createState() => _LocateState();
}

class _LocateState extends State<Locate> {
  @override
  void initState(){
    super.initState();
    getLocation();
  }


  void getLocation() async {
    Location _location = Location();
    bool? _serviceEnabled;
    PermissionStatus? _permissionGranted;

    _serviceEnabled = await _location.serviceEnabled();
    if (!_serviceEnabled!) {
      _serviceEnabled = await _location.requestService();
    }

    _permissionGranted = await _location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await _location.requestPermission();
    }

    LocationData _locationData = await _location.getLocation();
    LatLng currentLatLng = LatLng(
        _locationData.latitude!, _locationData.longitude!);

    sharedPreferences.setDouble('latitude', _locationData.latitude!);
    sharedPreferences.setDouble('longitude', _locationData.longitude!);
/*
    Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (_)=> const HomeManagement()),
        (route) => false);
  }*/


  }
  @override
  Widget build(BuildContext context){
    return HomeManagement();
  }
}