import 'package:shared_preferences/shared_preferences.dart';

class SessionManager {
  int? idUser;

  Future<void> saveSession(int myId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
  }

  Future getSession() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    idUser = prefs.getInt("id");
    return idUser;
  }

  Future clearSession() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }
}

final session = SessionManager();