import 'dart:io';

import 'package:phonebook/common/const/data.dart' as data;

class Config {
  final String baseUrl;

  Config._dev()
      : baseUrl =
            Platform.isAndroid ? data.emulatorIp : data.simulatorIp; // dev url

  Config._product() : baseUrl = data.baseUrl; // product url

  factory Config(String? _flavor) {
    if (_flavor == 'dev') {
      instance = Config._dev();
    } else if (_flavor == 'prod') {
      instance = Config._product();
    } else {
      throw Exception("Unknown flaver : $_flavor}");
    }

    return instance;
  }

  static late final Config instance;
}
