import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationsProvider extends ChangeNotifier {
  int _notificacionesLeidas = 0;

  int get notificacionesLeidas => _notificacionesLeidas;

  NotificationsProvider() {
    _recuperarNotificacionesLeidas();
  }

  Future<void> _recuperarNotificacionesLeidas() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _notificacionesLeidas = prefs.getInt('_notificacionesLeidas') ?? 0;
    notifyListeners();
  }

  void actualizarNotificacionesLeidas(int cantidad) async {
    _notificacionesLeidas = cantidad;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('_notificacionesLeidas', cantidad);

    notifyListeners();
  }
}
