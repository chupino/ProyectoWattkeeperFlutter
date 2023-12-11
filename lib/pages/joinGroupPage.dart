import 'package:flutter/material.dart';
import 'package:wattkeeperr/components/groups/join/joinGroupScheme.dart';



class JoinGroupPage extends StatelessWidget {
  final String token;
  const JoinGroupPage({super.key, required this.token});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Unirse a Grupo',
          ),
        ),
        body: JoinGroupScheme(
          token: token,
        ));
  }
}
