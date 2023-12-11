import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:wattkeeperr/components/groups/NonGroups.dart';
import 'package:wattkeeperr/components/groups/groupCard.dart';
import 'package:wattkeeperr/components/home/errorScreen.dart';
import 'package:wattkeeperr/components/loading/loadingAnimation.dart';
import 'package:wattkeeperr/controllers/GroupController.dart';
import 'package:wattkeeperr/models/Group.dart';

class GroupsBuilder extends StatefulWidget {
  final String selectedGroup;
  final String token;
  const GroupsBuilder(
      {super.key, required this.selectedGroup, required this.token});

  @override
  State<GroupsBuilder> createState() => _GroupsBuilderState();
}

class _GroupsBuilderState extends State<GroupsBuilder> {
  final controller = GroupController();
  List<Group> misGrupos = [];
  bool isInitialize = false;
  bool loading = true;
  bool loadingError = false;

  initData(bool reload) async {
    setState(() {
      isInitialize = false;
      loading = true;
      loadingError = false;
    });
    try {
      await Future.delayed(Duration(seconds: 10), () async {
        misGrupos =
            await controller.getGroupsUser(widget.token, widget.selectedGroup);
      });
      setState(() {
        isInitialize = true;
        loadingError = false;
        loading = false;
      });
      print("++++++++ok");
    } catch (e) {
      setState(() {
        isInitialize = true;
        loadingError = true;
        loading = false;
      });
      print("Se produjo un error grupos: $e");
    }
  }

  Future<void> handleRefresh() async {
    await initData(true);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initData(false);
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? LoadingAnimation()
        : loadingError
            ? ErrorScreen(reload: handleRefresh)
            : isInitialize
                ? (misGrupos.isNotEmpty
                    ? Column(
                        children: misGrupos
                            .map(
                                (e) => GroupCard(group: e, token: widget.token))
                            .expand((widget) => [
                                  widget,
                                  SizedBox(height: 10),
                                ])
                            .toList(),
                      )
                    : const NonGroups())
                : LoadingAnimation();
  }
}
