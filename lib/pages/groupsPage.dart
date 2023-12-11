import 'package:flutter/material.dart';
import 'package:wattkeeperr/components/groups/groupsBuilder.dart';
import 'package:wattkeeperr/components/groups/joinGroupSection.dart';
import 'package:wattkeeperr/components/groups/selectGroup.dart';
import 'package:wattkeeperr/components/loading/loadingAnimation.dart';

class GroupsPage extends StatefulWidget {
  final String token;
  const GroupsPage({super.key, required this.token});

  @override
  State<GroupsPage> createState() => _GroupsPageState();
}

class _GroupsPageState extends State<GroupsPage> {
  String groupSelected = "Grupos Afiliados";

  @override
  Widget build(BuildContext context) {
    void changeGroup(String value) {
      setState(() {
        groupSelected = value;
      });
    }

    return Scaffold(
        body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  GroupsBuilder(
                      selectedGroup: groupSelected, token: widget.token)
                ],
              ),
            )));
  }
}
