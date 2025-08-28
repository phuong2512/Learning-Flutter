import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';

class RemoteConfigService {
  final FirebaseRemoteConfig _remoteConfig = FirebaseRemoteConfig.instance;

  Future<void> initialize() async {
    await _remoteConfig.setConfigSettings(
      RemoteConfigSettings(
        fetchTimeout: const Duration(minutes: 1),
        minimumFetchInterval: const Duration(hours: 1),
      ),
    );

    await _remoteConfig.setDefaults({
      "primaryColor": '0xFF3CFAAE',
      "floatingActionButtonShape": 'beveled',
    });

    await _remoteConfig.fetchAndActivate();

    _remoteConfig.onConfigUpdated.listen((event) async {
      await _remoteConfig.activate();
      debugPrint("Remote Config updated, activated new values.");
      _onConfigChanged?.call();
    });
  }

  VoidCallback? _onConfigChanged;
  void setOnConfigChanged(VoidCallback callback) {
    _onConfigChanged = callback;
  }

  String getPrimaryColor() => _remoteConfig.getString('primaryColor');

  ShapeBorder? getFloatingActionButtonShape() {
    final shape = _remoteConfig.getString('floatingActionButtonShape');
    switch (shape) {
      case 'stadium':
        return const StadiumBorder();
      case 'circle':
        return const CircleBorder();
      case 'rounded':
        return RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        );
      case 'beveled':
        return BeveledRectangleBorder();
      default:
        return null;
    }
  }
}
