import 'package:shared_preferences/shared_preferences.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

part 'local_storage_service.g.dart';

@riverpod
LocalStorageService localStorageService(Ref ref) => LocalStorageService();

class LocalStorageService {
  late SharedPreferences? _sharedPreferences;

  Future<void> init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  void setToken(String? token) {
    if (token != null) {
      _sharedPreferences?.setString('x-auth-token', token);
    }
  }

  String? getToken() {
    return _sharedPreferences?.getString('x-auth-token');
  }
}
