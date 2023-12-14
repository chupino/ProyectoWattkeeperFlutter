import 'package:flutter/material.dart';
import 'package:wattkeeperr/components/home/consejo.dart';
import 'package:wattkeeperr/components/home/deviceExpensiveCard.dart';
import 'package:wattkeeperr/components/home/errorScreen.dart';
import 'package:wattkeeperr/components/home/groupSection.dart';
import 'package:wattkeeperr/components/home/headerHome.dart';
import 'package:wattkeeperr/components/home/welcomeHome.dart';
import 'package:wattkeeperr/components/loading/loadingAnimation.dart';
import 'package:wattkeeperr/controllers/DeviceController.dart';
import 'package:wattkeeperr/controllers/GroupController.dart';
import 'package:wattkeeperr/controllers/SessionController.dart';
import 'package:wattkeeperr/models/Consejo.dart';
import 'package:wattkeeperr/models/Device.dart';
import 'package:wattkeeperr/models/DeviceExpensive.dart';
import 'package:wattkeeperr/models/Group.dart';
import 'package:wattkeeperr/models/User.dart';

class HomeScheme extends StatefulWidget {
  final String token;

  const HomeScheme({super.key, required this.token});

  @override
  State<HomeScheme> createState() => _HomeSchemeState();
}

class _HomeSchemeState extends State<HomeScheme> {
  final userController = SessionController();
  final groupController = GroupController();
  final deviceController = DeviceController();
  late User user;
  late List<Group> grupos;
  late DeviceExpensive? deviceExpensive;
  late Consejo consejo;
  late List<Device> devices;

  bool isInitialize = false;
  bool loadingError = false;
  bool loading = true;

  Future<void> initData(bool refresh) async {
    setState(() {
      isInitialize = false;
      loadingError = false;
      loading = true;
    });
    try {
      await userController.getDataUser(widget.token).then((value) {
        user = value;
      }).timeout(Duration(seconds: 10));
      await userController.getConsejo(widget.token).then((value) {
        consejo = value;
      }).timeout(Duration(seconds: 10));
      await groupController
          .getGroupsUser(widget.token, "Grupos Afiliados")
          .then((value) {
        grupos = value;
      }).timeout(Duration(seconds: 10));
      await deviceController.getDeviceMostExpensive(widget.token).then((value) {
        deviceExpensive = value;
      }).timeout(Duration(seconds: 10));
      await deviceController.getDevicesUser(widget.token).then((value) {
        devices = value;
      }).timeout(Duration(seconds: 10));

      setState(() {
        isInitialize = true;
        loadingError = false;
        loading = false;
      });
    } catch (e) {
      setState(() {
        isInitialize = true;
        loadingError = true;
        loading = false;
      });
      print("Se produjo un error: $e");
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
            ? ErrorScreen(
                reload: handleRefresh,
              )
            : isInitialize
                ? RefreshIndicator(
                    onRefresh: handleRefresh,
                    child: ListView(
                      shrinkWrap: false,
                      padding: EdgeInsets.zero,
                      children: [
                        deviceExpensive != null
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Dispositivo que mas consume",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineLarge,
                                  ),
                                  Divider(),
                                  DeviceExpensiveCard(
                                    deviceExpensive: deviceExpensive!,
                                    devices: devices,
                                    token: widget.token,
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                ],
                              )
                            : Container(),
                        Text(
                          "Consejo del día",
                          style: Theme.of(context).textTheme.headlineLarge,
                        ),
                        Divider(),
                        const SizedBox(
                          height: 20,
                        ),
                        ConsejoCard(consejo: consejo),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Grupos Recientes",
                          style: Theme.of(context).textTheme.headlineLarge,
                        ),
                        Divider(),
                        const SizedBox(
                          height: 20,
                        ),
                        GroupSection(
                          token: widget.token,
                          grupos: grupos.take(2).toList(),
                        ),
                      ],
                    ),
                  )
                : LoadingAnimation();
  }
}
