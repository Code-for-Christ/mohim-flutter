import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const ACCESS_TOKEN_KEY = 'ACCESS_TOKEN';
const REFRESH_TOKEN_KEY = 'REFRESH_TOKEN';

const emailPattern = r'^[a-zA-Z0-9+-\_.]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$';
const passwordPattern = r"^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d@!%*#?&:]{8,}$";

// localhost
final emulatorIp = 'http://10.0.2.2:8000/api/v1';
final simulatorIp = 'http://127.0.0.1:8000/api/v1';

// baseUrl
final baseUrl = 'https://mohim-api.com/api/v1';
final storage = FlutterSecureStorage();
