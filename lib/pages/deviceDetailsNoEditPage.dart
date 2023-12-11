import 'package:flutter/material.dart';
import 'package:wattkeeperr/components/devices/details/header/header.dart';
import 'package:wattkeeperr/components/groups/details/devices/devicesDetailsNoEditScheme.dart';
import 'package:wattkeeperr/components/loading/loadingAnimation.dart';
import 'package:wattkeeperr/controllers/DeviceController.dart';
import 'package:wattkeeperr/models/Device.dart';

class DeviceDetailsNoEditPage extends StatefulWidget {
  final Device device;
  final String token;
  const DeviceDetailsNoEditPage({super.key, required this.device, required this.token});

  @override
  State<DeviceDetailsNoEditPage> createState() =>
      _DeviceDetailsNoEditPageState();
}

class _DeviceDetailsNoEditPageState extends State<DeviceDetailsNoEditPage> {
  final controller = DeviceController();
  Map<String, dynamic> deviceForm = {};
  int dummy = 0;
  bool wasEditable = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: FutureBuilder(
          future: controller.getDeviceDetailsUser(
              widget.token, widget.device.id, dummy),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return CustomScrollView(
                slivers: [
                  SliverPersistentHeader(
                      pinned: true,
                      delegate: DevicesHeader(
                        deviceDetails: snapshot.data!,
                        size: size,
                        token: widget.token,
                      )),
                  SliverList(
                      delegate: SliverChildListDelegate([
                    DeviceDetailsNoEditScheme(
                            token: widget.token,
                            deviceDetails: snapshot.data!,
                          )
                  ]))
                ],
              );
            } else {
              return LoadingAnimation();
            }
          }),
    );
  }
}
