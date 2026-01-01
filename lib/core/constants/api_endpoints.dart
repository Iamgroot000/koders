class ApiEndpoints {
  ApiEndpoints._(); // Prevent instantiation

  // Base URLs
  static const String baseUrl = 'https://jsonplaceholder.typicode.com';
  static const String authBaseUrl = ApiEndpoints.baseUrl;

  // Auth
  static const String login = '$authBaseUrl/users/1';

  // Posts
  static const String posts = '$baseUrl/posts';
}
