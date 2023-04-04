import 'dart:io';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const ACCESS_TOKEN_KEY = 'ACCESS_TOKEN';
const REFRESH_TOKEN_KEY = 'REFRESH_TOKEN';

const emailPattern = r'^[a-zA-Z0-9+-\_.]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$';
const passwordPattern =
    r'^(?=.*[A-Za-z])(?=.*\d)(?=.*[@!%*#?&])[A-Za-z\d@!%*#?&]{8,}$';

// localhost
final emulatorIp = '10.0.2.2:8000/api/v1';
final simulatorIp = '127.0.0.1:8000/api/v1';

// final ip = Platform.isIOS ? simulatorIp : emulatorIp;

// Server IP
final ip = '52.79.157.230/api/v1';
final storage = FlutterSecureStorage();
