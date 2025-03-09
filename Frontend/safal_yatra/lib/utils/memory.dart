import 'package:shared_preferences/shared_preferences.dart';

class Memory {
  static SharedPreferences? prefs;

  static Future<void> init() async {
    prefs = await SharedPreferences.getInstance();
  }

  static void saveToken(String token) async {
    await prefs?.setString('token', token);
  }

  static String? getToken() {
    return prefs?.getString('token');
  }

  static void saveRole(String role) async {
    await prefs?.setString('role', role);
  }

  static String? getRole() {
    return prefs?.getString('role');
  }

  static void clear() async {
    await prefs?.clear();
  }
} 