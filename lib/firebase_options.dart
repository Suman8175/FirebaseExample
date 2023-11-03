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
    apiKey: 'AIzaSyCdmNgIBJDmVjCAYwX3187IHaEIinaRBDE',
    appId: '1:629344242908:web:13ab81e75cb649b2453819',
    messagingSenderId: '629344242908',
    projectId: 'testoffirebaseauth',
    authDomain: 'testoffirebaseauth.firebaseapp.com',
    storageBucket: 'testoffirebaseauth.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyB0VJqA6IQudiKL2FC4RqjwSTirNo3YKWg',
    appId: '1:629344242908:android:87e9c8123f8984ab453819',
    messagingSenderId: '629344242908',
    projectId: 'testoffirebaseauth',
    storageBucket: 'testoffirebaseauth.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBHfT53fv3RoTEW3suLLovHHRZW1rYzVj4',
    appId: '1:629344242908:ios:3bccef55bd689126453819',
    messagingSenderId: '629344242908',
    projectId: 'testoffirebaseauth',
    storageBucket: 'testoffirebaseauth.appspot.com',
    iosBundleId: 'com.example.firebaseauthexample',
  );
}
