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
    apiKey: 'AIzaSyAmSbswm3xs8dpMzkWEL4qPF4NhULeez8c',
    appId: '1:968945988064:web:a834644cb8eeb4b6527b85',
    messagingSenderId: '968945988064',
    projectId: 'tiktok-rud',
    authDomain: 'tiktok-rud.firebaseapp.com',
    storageBucket: 'tiktok-rud.appspot.com',
    measurementId: 'G-EF9QHTQGXV',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCe63H8HnRhZP0RWsL2i2iexujyhDQjhk8',
    appId: '1:968945988064:android:11dd8a4b796f3225527b85',
    messagingSenderId: '968945988064',
    projectId: 'tiktok-rud',
    storageBucket: 'tiktok-rud.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBIsXrd06gQoaqRRBaElDr5ep0pWK1hV6Y',
    appId: '1:968945988064:ios:ae02a7bb2c25e3d2527b85',
    messagingSenderId: '968945988064',
    projectId: 'tiktok-rud',
    storageBucket: 'tiktok-rud.appspot.com',
    iosBundleId: 'com.example.tiktokClone',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBIsXrd06gQoaqRRBaElDr5ep0pWK1hV6Y',
    appId: '1:968945988064:ios:ae02a7bb2c25e3d2527b85',
    messagingSenderId: '968945988064',
    projectId: 'tiktok-rud',
    storageBucket: 'tiktok-rud.appspot.com',
    iosBundleId: 'com.example.tiktokClone',
  );
}
