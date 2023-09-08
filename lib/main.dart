import 'package:chatapp/ChatApp.dart';
import 'package:chatapp/services/AuthService.dart';
import 'package:chatapp/services/RemoteConfigService.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
//import 'package:firebase_crashlytics/firebase_crashlytics.dart';
//import 'package:firebase_performance/firebase_performance.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
    apiKey: "AIzaSyAfGWS4NLgSrq4mvSmmAQJoKVbZfOjHliM",
    authDomain: "chatapp-54f39.firebaseapp.com",
    projectId: "chatapp-54f39",
    messagingSenderId: "800670910980",
    appId: "1:800670910980:web:91367075faa6a9d9a68351",
    storageBucket: "chatapp-54f39.appspot.com",
  ));

  // FirebaseCrashlytics.instance.crash();
  //FirebasePerformance performance = FirebasePerformance.instance;
  await FirebaseRemoteConfigService().initialize();
  runApp(ChangeNotifierProvider(
      create: (context) {
        return AuthService();
      },
      child: ChatApp()));
}
