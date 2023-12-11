import 'dart:convert';

import 'package:wattkeeperr/core/constants/urls.dart';
import 'package:wattkeeperr/models/Group.dart';
import 'package:wattkeeperr/models/GroupDetails.dart';
import 'package:http/http.dart' as http;
import 'package:wattkeeperr/models/GroupMedicion.dart';

class GroupController {
  Future<List<GroupMedicion>> getGroupMedicion(String token, int id) async {
    try {
      final String url = "${Urls.backendDjango}/api_mongo/consumo/grupos/$id";
      final response = await http
          .get(Uri.parse(url), headers: {"Authorization": "token $token"});
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        List<GroupMedicion> mediciones = (data["data"] as List)
            .map((e) => GroupMedicion.fromJson(e as Map<String, dynamic>))
            .toList();
        return mediciones;
      } else {
        throw "Se produjo un error el recuperar la medicion de este grupo";
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Group>> getGroupsUser(String token, String selectedGroup) async {
    try {
      String group = "grupos_creados";
      switch (selectedGroup) {
        case "Mis Grupos":
          group = "grupos_creados";
          break;
        case "Grupos Afiliados":
          group = "grupos_afiliado";
          break;
        default:
          group = "grupos_creados";
      }
      final String url = "${Urls.backendDjango}/api/grupos";
      final response = await http
          .get(Uri.parse(url), headers: {"Authorization": "token $token"});
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        List<Group> grupos = (data['data'][group] as List)
            .map((element) => Group.fromJson(element as Map<String, dynamic>))
            .toList();
        //print(grupos);
        return grupos;
      } else {
        throw "Error al recuperar informacion de grupos";
      }
    } catch (e) {
      print("Error del modelo");
      print(e);
      throw e.toString();
    }
  }

  Future<GroupDetails> getDetailsGroup(String token, int id) async {
    try {
      final String url = "${Urls.backendDjango}/api/grupos/$id";
      final response = await http
          .get(Uri.parse(url), headers: {"Authorization": "token $token"});
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print(data);
        GroupDetails grupo = GroupDetails.fromJson(data["data"]["grupo"]);
        print(grupo);
        return grupo;
      } else {
        throw "Error al recuperar informacion de grupos";
      }
    } catch (e) {
      print("Error en el modelo de detalle");
      print(e);
      throw e.toString();
    }
  }

  Future<bool> joinGroup(String token, String tokenInvitacion) async {
    try {
      print("token invitacion $tokenInvitacion");
      final String url = "${Urls.backendDjango}/api/grupos/affiliate";
      final response = await http.post(Uri.parse(url),
          headers: {"Authorization": "token $token"},
          body: {"tokenUrl": tokenInvitacion});
      //final data = jsonDecode(response.body);
      //print(data);
      if (response.statusCode == 204) {
        return true;
      } else {
        final data = jsonDecode(response.body);
        print(data);
        return false;
      }
    } catch (e) {
      print(e);
      throw e.toString();
    }
  }

  Future<bool> leaveGroup(String token, int id) async {
    try {
      final String url = "${Urls.backendDjango}/api/grupos/affiliate/$id";
      final response = await http
          .delete(Uri.parse(url), headers: {"Authorization": "token $token"});
      //final data = jsonDecode(response.body);
      //print(data);
      if (response.statusCode == 204) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
      throw e.toString();
    }
  }
}
