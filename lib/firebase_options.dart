// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyD3rUWxHCyV_P-cadSxkMvoAHR-B3XeqyM',
    appId: '1:77341737166:web:e6dd09599e374dbe77909f',
    messagingSenderId: '77341737166',
    projectId: 'pleasemap-3a3be',
    authDomain: 'pleasemap-3a3be.firebaseapp.com',
    storageBucket: 'pleasemap-3a3be.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCdeOGbxk6JBNcA61ADFB-_Fq0jwTw8P-0',
    appId: '1:77341737166:android:817f333aff9e8f4477909f',
    messagingSenderId: '77341737166',
    projectId: 'pleasemap-3a3be',
    storageBucket: 'pleasemap-3a3be.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDFbT_ZgtXUDpckaifxE6BPHQ8d3NinSK8',
    appId: '1:77341737166:ios:2f93e7738f64a06e77909f',
    messagingSenderId: '77341737166',
    projectId: 'pleasemap-3a3be',
    storageBucket: 'pleasemap-3a3be.appspot.com',
    iosBundleId: 'com.example.kanha1011',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDFbT_ZgtXUDpckaifxE6BPHQ8d3NinSK8',
    appId: '1:77341737166:ios:2f93e7738f64a06e77909f',
    messagingSenderId: '77341737166',
    projectId: 'pleasemap-3a3be',
    storageBucket: 'pleasemap-3a3be.appspot.com',
    iosBundleId: 'com.example.kanha1011',
  );
}
