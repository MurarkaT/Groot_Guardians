import 'package:kanha1011/main.dart';
import 'package:mapbox_gl/mapbox_gl.dart';

LatLng getLatLngFromSharedPrefs(){
  return LatLng(sharedPreferences.getDouble('latitude')!,sharedPreferences.getDouble('longitude')!);
}