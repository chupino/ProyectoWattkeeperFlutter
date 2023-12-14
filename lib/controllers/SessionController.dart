import 'dart:convert';

import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wattkeeperr/core/constants/urls.dart';
import 'package:http/http.dart' as http;
import 'package:wattkeeperr/models/Consejo.dart';
import 'package:wattkeeperr/models/User.dart';

class SessionController {
  Future<bool> updatePassword(String token, String oldPassword, String newPassword, String newPasswordConfirmation) async {
    try {
      final String url = "${Urls.backendDjango}/api/user/password";
      final response = await http.put(Uri.parse(url), headers: {
        "Authorization": "token $token"
      }, body: {
        "password": oldPassword,
        "new_password": newPassword,
        "new_password_confirmation": newPasswordConfirmation,
      });
      if (response.statusCode == 204) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
      throw e;
    }
  }
  Future<bool> updateDataUser(String token, String nombre, String apellido,
      String fechaNac, String email) async {
    try {
      final String url = "${Urls.backendDjango}/api/user";
      final response = await http.put(Uri.parse(url), headers: {
        "Authorization": "token $token"
      }, body: {
        "nombres": nombre,
        "apellidos": apellido,
        "email": email,
        "fecha_nacimiento": fechaNac
      });
      if (response.statusCode == 204) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Future<bool> updateConfiguration(String token, bool groupAlerts,
      bool deviceAlerts, bool redeemAlerts) async {
    try {
      final String url = "${Urls.backendDjango}/api/user/config";
      final response = await http.put(Uri.parse(url), headers: {
        "Authorization": "token $token"
      }, body: {
        "alerta_limite_grupo": groupAlerts.toString(),
        "alerta_limite_dispositivo": deviceAlerts.toString(),
        "alerta_recompensa": redeemAlerts.toString()
      });
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
      throw e.toString();
    }
  }

  Future<bool> login(String email, String password) async {
    try {
      print("email: $email, password: $password");
      final String endPointLogin = "${Urls.backendDjango}/api/login";
      final response = await http.post(Uri.parse(endPointLogin),
          body: {"email": email, "password": password});
      final data = jsonDecode(response.body);
      print(data);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final token = data["data"]["token"];
        saveToken(token);
        saveLogin();
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
      throw e.toString();
    }
  }

  Future<bool> register(
      String email,
      String nombres,
      String apellidos,
      String password,
      String passwordConfirmation,
      String fechaNacimiento) async {
    try {
      print(
          "email:$email\npassword: $password\npasswordConfirmation: $passwordConfirmation\nnombres:$nombres\napellidos: $apellidos\nfechaNacimiento: $fechaNacimiento");
      DateTime parsedDate =
          DateFormat('dd MMMM y', 'es').parse(fechaNacimiento);
      String fechaNacFinal = DateFormat('yyyy-MM-dd').format(parsedDate);
      final String url = "${Urls.backendDjango}/api/register";
      final response = await http.post(Uri.parse(url), body: {
        "nombres": nombres,
        "apellidos": apellidos,
        "email": email,
        "password": password,
        "password_confirmation": passwordConfirmation,
        "fecha_nacimiento": fechaNacFinal
      });
      final data = jsonDecode(response.body);
      print(data);
      if (response.statusCode == 201) {
        final token = data["data"]["token"];
        saveToken(token);
        saveLogin();
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
      throw e.toString();
    }
  }

  Future<bool> logout(String token) async {
    try {
      final String url = "${Urls.backendDjango}/api/logout";
      final response = await http
          .post(Uri.parse(url), headers: {"Authorization": "token $token"});
      //print(response.body);
      if (response.statusCode == 204) {
        deleteToken(token);
        deleteLogin();
        return true;
      } else {
        throw "Error al recuperar informacion";
      }
    } catch (e) {
      print(e);
      throw e.toString();
    }
  }

  Future<Consejo> getConsejo(String token) async {
    try {
      final String url = "${Urls.backendDjango}/api_mongo/consejo";
      final response = await http
          .get(Uri.parse(url), headers: {"Authorization": "token $token"});
      //print(response.body);
      final data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        Consejo consejo = Consejo.fromJson(data['data']['consejo']);
        return consejo;
      } else {
        throw "Error al recuperar informacion";
      }
    } catch (e) {
      print(e);
      throw e.toString();
    }
  }

  Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('token', token);
  }

  Future<void> deleteToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('token');
  }

  Future<String> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("token") ?? "";
  }

  Future<void> saveLogin() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('isLogged', true);
  }

  Future<void> deleteLogin() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('isLogged', false);
  }

  Future<User> getDataUser(String token) async {
    try {
      final String url = "${Urls.backendDjango}/api/user";
      final response = await http
          .get(Uri.parse(url), headers: {"Authorization": "token $token"});
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return User.fromJson(data['data']['usuario']);
      } else {
        throw "Error al recuperar informacion de Usuario";
      }
    } catch (e) {
      print(e);
      throw e.toString();
    }
  }

  Future<void> passOnBoard() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('onBoardSkip', true);
  }
}
