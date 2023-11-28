import 'package:rzf_canvasing_sirwal/data/global_variable.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static const _userIdKey = "AUTH-USER-ID ";

  static save(int userId) async {
    final sp = await SharedPreferences.getInstance();
    await sp.setInt(_userIdKey, userId);
  }

  static load() async {
    final sp = await SharedPreferences.getInstance();
    GlobalVar.userId = sp.getInt(_userIdKey) ?? 0;
  }

  static clear() async {
    final sp = await SharedPreferences.getInstance();
    await sp.clear();
  }
}
