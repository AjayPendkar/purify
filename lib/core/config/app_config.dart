enum Flavor {
  development,
  staging,
  production,
}

class AppConfig {
  static final AppConfig instance = AppConfig._internal();
  AppConfig._internal();

  late Flavor _flavor;
  String? _baseUrl;

  void setFlavor(Flavor flavor) {
    _flavor = flavor;
    switch (flavor) {
      case Flavor.development:
        _baseUrl = 'https://519b-2409-40f0-105-531f-353f-88d0-3171-744b.ngrok-free.app';
        break;
      case Flavor.staging:
        _baseUrl = 'https://staging-api.example.com';
        break;
      case Flavor.production:
        _baseUrl = 'https://api.example.com';
        break;
    }
  }

  Flavor get flavor => _flavor;
  String get baseUrl => _baseUrl ?? 'https://c14b-2409-40f0-11d0-54-c0e9-761d-addf-b563.ngrok-free.app';
} 