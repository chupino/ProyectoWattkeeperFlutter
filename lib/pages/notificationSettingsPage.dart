import 'package:flutter/material.dart';
import 'package:wattkeeperr/components/settings/notifications/notificationsScheme.dart';

class NotificationSettingsPage extends StatelessWidget {
  final String token;
  const NotificationSettingsPage({super.key, required this.token});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notificaciones"),
      ),
      body: Padding(padding: EdgeInsets.all(8.0),child: NotificationsSettingsScheme(token: token,),),
    );
  }
}
