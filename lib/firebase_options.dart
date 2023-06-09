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
    apiKey: 'AIzaSyChl-AzVospUcHD2N1SkWc1ihOHHI4nY0U',
    appId: '1:119190073756:web:23a69364cbc96690ad5859',
    messagingSenderId: '119190073756',
    projectId: 'proyecto2-fc454',
    authDomain: 'proyecto2-fc454.firebaseapp.com',
    storageBucket: 'proyecto2-fc454.appspot.com',
    measurementId: 'G-1S0HM87KBX',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyB7tO5G5ArlWtMu1N8rHD8s1cWpoeHjwys',
    appId: '1:119190073756:android:dc4ffaf716e87581ad5859',
    messagingSenderId: '119190073756',
    projectId: 'proyecto2-fc454',
    storageBucket: 'proyecto2-fc454.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyC94FakKdRX5-l5c5mJ6ZTM4Tr120Nr8iI',
    appId: '1:119190073756:ios:a9aa7571656d4cd3ad5859',
    messagingSenderId: '119190073756',
    projectId: 'proyecto2-fc454',
    storageBucket: 'proyecto2-fc454.appspot.com',
    iosClientId: '119190073756-5muumbpm51i7985k7jdrdrs2vu8d9ca1.apps.googleusercontent.com',
    iosBundleId: 'mx.edu.ittepic.damU4Proyecto218401084',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyC94FakKdRX5-l5c5mJ6ZTM4Tr120Nr8iI',
    appId: '1:119190073756:ios:a9aa7571656d4cd3ad5859',
    messagingSenderId: '119190073756',
    projectId: 'proyecto2-fc454',
    storageBucket: 'proyecto2-fc454.appspot.com',
    iosClientId: '119190073756-5muumbpm51i7985k7jdrdrs2vu8d9ca1.apps.googleusercontent.com',
    iosBundleId: 'mx.edu.ittepic.damU4Proyecto218401084',
  );
}
