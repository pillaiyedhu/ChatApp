import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';

class FirebaseRemoteConfigService {
  FirebaseRemoteConfigService._()
      : remoteConfig = FirebaseRemoteConfig.instance;

  //making it singleton
  static FirebaseRemoteConfigService? _instance;
  factory FirebaseRemoteConfigService() =>
      _instance ??= FirebaseRemoteConfigService._();

  final FirebaseRemoteConfig remoteConfig;

  String getString(String key) => remoteConfig.getString(key);
  bool getBool(String key) => remoteConfig.getBool(key);
  int getInt(String key) => remoteConfig.getInt(key);
  double getDouble(String key) => remoteConfig.getDouble(key);



  Future<void> setConfigSettings() async =>
      remoteConfig.setConfigSettings(RemoteConfigSettings(
          fetchTimeout: const Duration(minutes: 1),
          minimumFetchInterval: const Duration(hours: 1)));

  Future<void> setDefaults() async {
    return remoteConfig
        .setDefaults(const {FirebaseRemoteConfigKeys.message: "Hey..welcome"});
  }

  Future<void> fetchAndActivate() async {
    bool updated = await remoteConfig.fetchAndActivate();

    if (updated) {
      debugPrint('The config has been updated.');
    } else {
      debugPrint('The config is not updated..');
    }
  }

  Future<void> initialize() async {
    await setConfigSettings();
    await setDefaults();
    await fetchAndActivate();
}
}
  final message =
      FirebaseRemoteConfigService().getString(FirebaseRemoteConfigKeys.message);

class FirebaseRemoteConfigKeys {
  static const String message = 'message';
}
