
import 'package:shared_preferences/shared_preferences.dart';

class LogoutUseCase {
  final SharedPreferences _sharedPreferences;

  LogoutUseCase(this._sharedPreferences);

  void call() async {
    await _sharedPreferences.clear();
  }
}