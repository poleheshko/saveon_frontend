class AppConfig {
  //Base API URL
  static const String baseUrl = 'http://209.38.164.226:3000';

  // API Endpoints
  static const String loginEndpoint = '/auth/login';
  static const String usersEndpoint = '/users';

  // You can also add other config values here
  static const int requestTimeoutSeconds = 30;
  static const bool debugMode = true; // You can check this with kDebugMode from Flutter foundation

  // Helper method to get full URL
  static String getUrl(String endpoint) {
    return '$baseUrl$endpoint';
  }
}