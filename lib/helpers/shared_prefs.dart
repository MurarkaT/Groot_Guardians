import 'package:groot_guardians/main.dart';
import 'package:mapbox_gl/mapbox_gl.dart';

import '../main2.dart';

LatLng getLatLngFromSharedPrefs(){
  return LatLng(sharedPreferences.getDouble('latitude')!,sharedPreferences.getDouble('longitude')!);
}