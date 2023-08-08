import 'package:firebase_remote_config/firebase_remote_config.dart';

class RemoteConfigService {
  late final FirebaseRemoteConfig _remoteConfig;

  void init() {
    _remoteConfig = FirebaseRemoteConfig.instance;
  }

  Future<void> setupRemoteConfig() async {
    await _remoteConfig.setConfigSettings(RemoteConfigSettings(
      fetchTimeout: const Duration(minutes: 1),
      minimumFetchInterval: const Duration(hours: 1),
    ));
  }

  Future<void> defaultSettings() async {
    await _remoteConfig.setDefaults(const {
      "showAddPostDialog": false,
    });
  }

  Future<void> fetchAndActivate() async {
    await _remoteConfig.fetchAndActivate();
  }

  bool showAddPostDialog() {
    return _remoteConfig.getBool('showAddPostDialog');
  }
}
