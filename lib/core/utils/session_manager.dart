import 'package:shared_preferences/shared_preferences.dart';

class SessionManager {
  static const String _tokenKey = 'auth_token';
  static const String _loginTimeKey = 'login_time';

  // Save token and login time
  Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, token);
    await prefs.setInt(_loginTimeKey, DateTime.now().millisecondsSinceEpoch);
  }

  // Get token
  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey);
  }

  // Check login status and expiry
  Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString(_tokenKey);
    final loginTime = prefs.getInt(_loginTimeKey);

    if (token == null || token.isEmpty || loginTime == null) {
      return false;
    }

    final currentTime = DateTime.now().millisecondsSinceEpoch;
    const oneHourInMillis = 60 * 60 * 1000; // 1 hour in milliseconds

    if (currentTime - loginTime > oneHourInMillis) {
      // Session expired, clear it
      await clearSession();
      return false;
    }

    return true;
  }

  // Clear session
  Future<void> clearSession() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
    await prefs.remove(_loginTimeKey);
  }
}
