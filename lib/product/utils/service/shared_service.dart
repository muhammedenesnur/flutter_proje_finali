import 'package:shared_preferences/shared_preferences.dart';

abstract class SharedService {
  Future<void> save(String key, dynamic value);
  Future<void> remove(String key);
  Future<void> clear();
  Future<void> initialize();
  Future<dynamic> get(String key);
}

final class SharedServiceImpl implements SharedService {
  SharedServiceImpl(this._sharedPreferences);
  final SharedPreferences _sharedPreferences;

  @override
  Future<void> save(String key, dynamic value) async {
    if (value is String) {
      await _sharedPreferences.setString(key, value);
    } else if (value is int) {
      await _sharedPreferences.setInt(key, value);
    } else if (value is double) {
      await _sharedPreferences.setDouble(key, value);
    } else if (value is bool) {
      await _sharedPreferences.setBool(key, value);
    } else if (value is List<String>) {
      await _sharedPreferences.setStringList(key, value);
    } else {
      throw Exception('Type is not supported');
    }
  }

  @override
  Future<void> remove(String key) async {
    await _sharedPreferences.remove(key);
  }

  @override
  Future<void> clear() async {
    await _sharedPreferences.clear();
  }

  @override
  Future<void> initialize() async {
    await _sharedPreferences.reload();
  }

  @override
  Future<dynamic> get(String key) async {
    return _sharedPreferences.get(key);
  }
}
