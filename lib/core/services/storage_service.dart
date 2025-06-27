import 'dart:convert';
import '../../data/models/user_model.dart';

class StorageService {
  static const String _userKey = 'user_data';
  static const String _themeKey = 'theme_mode';
  static const String _languageKey = 'selected_language';
  
  // Mock storage for demo
  static Map<String, dynamic> _storage = {};
  
  Future<void> storeUser(UserModel user) async {
    try {
      final userJson = json.encode(user.toJson());
      _storage[_userKey] = userJson;
    } catch (e) {
      throw Exception('Failed to store user data: $e');
    }
  }
  
  Future<UserModel?> getUser() async {
    try {
      final userJson = _storage[_userKey] as String?;
      
      if (userJson != null) {
        final userMap = json.decode(userJson);
        return UserModel.fromJson(userMap);
      }
      
      return null;
    } catch (e) {
      return null;
    }
  }
  
  Future<void> clearUser() async {
    try {
      _storage.remove(_userKey);
    } catch (e) {
      throw Exception('Failed to clear user data: $e');
    }
  }
  
  Future<void> setThemeMode(bool isDark) async {
    try {
      _storage[_themeKey] = isDark;
    } catch (e) {
      throw Exception('Failed to store theme mode: $e');
    }
  }
  
  Future<bool> getThemeMode() async {
    try {
      return _storage[_themeKey] as bool? ?? false;
    } catch (e) {
      return false;
    }
  }
  
  Future<void> setLanguage(String language) async {
    try {
      _storage[_languageKey] = language;
    } catch (e) {
      throw Exception('Failed to store language: $e');
    }
  }
  
  Future<String> getLanguage() async {
    try {
      return _storage[_languageKey] as String? ?? 'English UK';
    } catch (e) {
      return 'English UK';
    }
  }
}
