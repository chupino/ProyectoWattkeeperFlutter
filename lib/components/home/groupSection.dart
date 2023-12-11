import 'package:flutter/material.dart';
import 'package:wattkeeperr/components/groups/NonGroups.dart';
import 'package:wattkeeperr/components/groups/groupCard.dart';
import 'package:wattkeeperr/controllers/GroupController.dart';
import 'package:wattkeeperr/models/Group.dart';

class GroupSection extends StatelessWidget {
  final List<Group> grupos;
  final String token;
  const GroupSection({super.key, required this.grupos, required this.token});

  @override
  Widget build(BuildContext context) {
    if (grupos.isNotEmpty) {
      List<Widget> gruposWidget =
          grupos.map((e) => GroupCard(group: e, token: token,)).toList();
      return Column(
        children: gruposWidget
            .map((widget) => Column(
                  children: [
                    widget,
                    SizedBox(
                        height:
                            10), // Agrega 10 puntos de espacio vertical entre los elementos
                  ],
                ))
            .toList(),
      );
    } else {
      return const NonGroups();
    }
  }
}
