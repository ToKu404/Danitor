import 'package:shared_preferences/shared_preferences.dart';

class AuthHelper {
  static const userToken = 'user_token';
  static AuthHelper? _authHelper;
  AuthHelper._instance() {
    _authHelper = this;
  }
  static SharedPreferences? _preferences;

  Future<SharedPreferences?> get preferences async {
    _preferences ??= await _initPreference();
    return _preferences;
  }

  factory AuthHelper() => _authHelper ?? AuthHelper._instance();

  Future<SharedPreferences> _initPreference() async {
    final pr = await SharedPreferences.getInstance();
    return pr;
  }

  Future<bool> checkUserIdExist() async {
    final pr = await preferences;
    return pr!.containsKey(userToken);
  }

  Future<bool> setUserId(String token) async {
    final pr = await preferences;
    return pr!.setString(userToken, token);
  }

  Future<String> getUserId() async {
    final pr = await preferences;
    String? userId = pr!.getString(userToken);

    return userId!;
  }

  Future<bool> removeUserId() async {
    final pr = await preferences;
    return pr!.remove(userToken);
  }
}
