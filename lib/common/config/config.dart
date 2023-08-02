class Config {
  final String baseUrl;
  final String token;

  Config._dev()
      : baseUrl = '', // dev url
        token = ''; // dev token

  Config._product()
      : baseUrl = '', // product url
        token = ''; // product token

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
