
import 'package:shared_preferences/shared_preferences.dart';

class UserAuthenticatedUseCase {
  final SharedPreferences _sharedPreferences;

  UserAuthenticatedUseCase(this._sharedPreferences);


  Future<bool> isUserAuthenticated() async {

    var accessToken = _sharedPreferences.getString("at");
    if (accessToken == null) {
      return false;
    }
    return true;
  }


}