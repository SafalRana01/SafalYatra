import 'package:shared_preferences/shared_preferences.dart';

class Memory {
  // SharedPreferences instance to store key-value pairs
  static SharedPreferences? prefs;

  // Initializing SharedPreferences
  static Future<void> init() async {
    prefs = await SharedPreferences.getInstance();
  }

  // Save authentication token
  static void saveToken(String token) async {
    await prefs?.setString('token', token);
  }

  // Retrieve authentication token
  static String? getToken() {
    return prefs?.getString('token');
  }

  // Save user role
  static void saveRole(String role) async {
    await prefs?.setString('role', role);
  }

  // Retrieve user role
  static String? getRole() {
    return prefs?.getString('role');
  }

  // Clear all stored preferences
  static void clear() async {
    await prefs?.clear();
  }
}
