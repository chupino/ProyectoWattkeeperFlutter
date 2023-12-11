import 'dart:convert';

import 'package:wattkeeperr/core/constants/urls.dart';
import 'package:wattkeeperr/models/Notification.dart';
import 'package:http/http.dart' as http;
import 'package:wattkeeperr/models/NotificationsDetails.dart';

class NotificationController {
  Future<List<NotificationModel>> getNotifications(String token) async {
    final String url = "${Urls.backendDjango}/api_mongo/notificaciones";
    final response = await http
        .get(Uri.parse(url), headers: {"Authorization": "token $token"});
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      List<NotificationModel> notificaciones =
          (data["data"]["recibidas"] as List)
              .map((e) => NotificationModel.fromJson(e as Map<String, dynamic>))
              .toList();
      return notificaciones;
    } else {
      throw "Error al recuperar notificaciones";
    }
  }

  Future<NotificationDetails> getNotification(String token, String id) async {
    try {
      final String url = "${Urls.backendDjango}/api_mongo/notificaciones/$id";
      final response = await http
          .get(Uri.parse(url), headers: {"Authorization": "token $token"});
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        NotificationDetails notification =
            NotificationDetails.fromJson(data["data"]["notificacion"]);
        return notification;
      } else {
        throw "Error al recuperar información";
      }
    } catch (e) {
      print("error modelo");
      print(e);
      throw e;
    }
  }
}
