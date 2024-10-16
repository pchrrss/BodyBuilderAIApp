// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyC-wZTrRS0ycnhQsuBQoCNnU0Va-Bkv670',
    appId: '1:361193016730:web:d8a95fe01c762b45743e23',
    messagingSenderId: '361193016730',
    projectId: 'bodybuilderai-fb5f9',
    authDomain: 'bodybuilderai-fb5f9.firebaseapp.com',
    storageBucket: 'bodybuilderai-fb5f9.appspot.com',
    measurementId: 'G-B5W5YK21Q0',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDNp7Dduh6NdLiYDMZHZuIczoH-aePAmDI',
    appId: '1:361193016730:android:dcdbd3433abf8cfe743e23',
    messagingSenderId: '361193016730',
    projectId: 'bodybuilderai-fb5f9',
    storageBucket: 'bodybuilderai-fb5f9.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBqY5NZpy9HV4cUam6pgSgUUJj_jg2un2I',
    appId: '1:361193016730:ios:3ad4fd4367592577743e23',
    messagingSenderId: '361193016730',
    projectId: 'bodybuilderai-fb5f9',
    storageBucket: 'bodybuilderai-fb5f9.appspot.com',
    iosBundleId: 'com.example.bodybuilderaiapp',
  );
}
