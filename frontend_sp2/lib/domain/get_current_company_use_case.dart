
import 'package:frontend_sp2/core/shared_prefs_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GetCurrentCompanyUseCase {
  final SharedPreferences _sharedPreferences;

  GetCurrentCompanyUseCase(this._sharedPreferences);

  Future<int> call() async {
    var data = _sharedPreferences
        .getInt(SharedPrefsKeys.currentSelectedCompany);

    return data ?? 0;
  }

}