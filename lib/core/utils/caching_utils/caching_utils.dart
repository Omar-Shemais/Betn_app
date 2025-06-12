import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CachingUtils {
  static late SharedPreferences _prefs;
  // static const String _keyProfileImage = 'profile_image';
  static const String userKey = 'user';
  static const String favKey = 'favorite_products';
  static const _imageKey = 'user_profile_image';

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static Future<int?> getCachedUserId() async {
    final userData = _prefs.getString('user');
    if (userData == null) return null;

    final parsed = json.decode(userData);
    return parsed['user']['id'];
  }

  static Future<void> cacheUser(Map<String, dynamic> data) async {
    await _prefs.setString('token', data['token']);
    await _prefs.setInt('id', data['user']['id']);
    await _prefs.setString('name', data['user']['name']);
    await _prefs.setString('message', data['message']);
  }

  static Future<void> saveUserData(Map<String, dynamic> data) async {
    await _prefs.setString('name', data['name']);
    // await _prefs.setInt('phone', data['phone']);
    await _prefs.setString('email', data['user']['email']);
    await _prefs.setString('address', data['address']);
  }

  static Future<void> cacheEmail(String email) async {
    await _prefs.setString('email', email);
  }

  static Future<void> cacheName(String fullName) async {
    await _prefs.setString('name', name);
  }

  // static Future<void> setProfileImagePath(String path) async {
  //   await _prefs.setString(_keyProfileImage, path);
  // }

  static Future<void> deleteUser() async {
    await _prefs.remove('token');
    await _prefs.remove('id');
  }

  static Future<void> cacheSignupMessage(String message) async {
    await _prefs.setString('message', message);
  }

  static String get signupMessage {
    return _prefs.getString('message') ?? '';
  }

  static bool get isLogged {
    return _prefs.containsKey('token');
  }

  static int get userID {
    return _prefs.getInt('id') ?? 0;
  }

  static String get token {
    return _prefs.getString('token') ?? '';
  }

  static String get email {
    return _prefs.getString('email') ?? '';
  }

  static String get name {
    return _prefs.getString('name') ?? '';
  }

  static String? getProfileImage() {
    return _prefs.getString('profile_image');
  }

  // static Future<String?> getProfileImagePath() async {
  //   return _prefs.getString(_keyProfileImage);
  // }
  static Future<void> saveImageToLocalStorage(File imageFile) async {
    final directory = await getApplicationDocumentsDirectory();
    final path = '${directory.path}/profile.jpg';
    final savedImage = await imageFile.copy(path);

    await _prefs.setString(_imageKey, savedImage.path);
  }

  static Future<String?> getSavedImagePath() async {
    return _prefs.getString(_imageKey);
  }

  // fav cach
  static Future<List<Map<String, dynamic>>> getFavoriteItems() async {
    final favJson = _prefs.getStringList(favKey) ?? [];
    return favJson.map((e) => json.decode(e) as Map<String, dynamic>).toList();
  }

  static Future<void> saveFavoriteItems(
    List<Map<String, dynamic>> favItems,
  ) async {
    final favJson = favItems.map((e) => json.encode(e)).toList();
    await _prefs.setStringList(favKey, favJson);
  }

  static Future<void> clearFavorites() async {
    await _prefs.remove(favKey);
  }
}
