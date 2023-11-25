import 'dart:typed_data';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:groot_guardians/helpers/shared_prefs.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:location/location.dart';

class DeviceMap extends StatefulWidget{
  const DeviceMap({Key? key}): super(key: key);

  @override
  State<DeviceMap> createState() => _DeviceMapState();
}

class _DeviceMapState  extends State<DeviceMap> {

  LatLng latlng= getLatLngFromSharedPrefs();
  late CameraPosition _initialCameraPosition;
  late MapboxMapController controller;
  Symbol? _selectedSymbol;
  void getLocation() async{
    Location _location=Location();
    bool? _serviceEnabled;
    PermissionStatus? _permissionGranted;

    _serviceEnabled=await _location.serviceEnabled();
    if(_serviceEnabled){
      _serviceEnabled = await _location.requestService();
    }

    _permissionGranted=await _location.hasPermission();
    if(_permissionGranted==PermissionStatus.denied){
      _permissionGranted=await _location.requestPermission();
    }

    LocationData _locationData=await _location.getLocation();
    LatLng currentLatLng=LatLng(
        _locationData.latitude!,_locationData.longitude!
    );

    setState(() {
      latlng=currentLatLng;
    });
  }
  @override
  void initState(){
    super.initState();
    getLocation();
    _initialCameraPosition=CameraPosition(target: latlng,zoom: 15);
  }

  FutureOr<Uint8List> loadMarkerImage() async {
    var byteData = await rootBundle.load("assets/images/location.png");
    return byteData.buffer.asUint8List();
  }

  void _onMapCreated(MapboxMapController controller) async {
    this.controller=controller;


    var image1=await loadMarkerImage();
    controller.addImage('marker', image1);

    await controller.addSymbol(
      SymbolOptions(
        iconSize: 0.3,
        geometry: latlng,
        iconImage: "marker",
      ),
    );
  }

  _onStyleLoadedCallback() async {}

  @override
  Widget build(BuildContext context){


    return Scaffold(
      appBar: AppBar(title: Text('Device Map')),
      body: Column(
            children: [
              SizedBox(
                  height: MediaQuery.of(context).size.height*0.8,
                  child: MapboxMap(
                    accessToken: "pk.eyJ1Ijoic3NvMSIsImEiOiJjbG9tdDdjdm4wNnp6MnZxczN1Z2NsZHdkIn0.nQ0C7w4pXOWZ82SlLU56Jw",
                    initialCameraPosition:_initialCameraPosition ,
                    onMapCreated: _onMapCreated,
                    onStyleLoadedCallback:_onStyleLoadedCallback ,
                    myLocationTrackingMode: MyLocationTrackingMode.TrackingGPS,
                    minMaxZoomPreference: const MinMaxZoomPreference(7, 17),
                  )
              ),

            ]
        ),


    );
  }
}
/*

  Padding(
                padding: EdgeInsets.only(top:600,left:300),
                  child:FloatingActionButton(

                  onPressed: (){
                    controller.animateCamera(
                        CameraUpdate.newCameraPosition(_initialCameraPosition));
                  },
                  child:const Icon(Icons.abc),
              )),
 */