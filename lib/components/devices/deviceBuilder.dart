import 'package:flutter/material.dart';
import 'package:wattkeeperr/components/devices/deviceCard.dart';
import 'package:wattkeeperr/components/devices/nonDevices.dart';
import 'package:wattkeeperr/components/home/errorScreen.dart';
import 'package:wattkeeperr/components/loading/loadingAnimation.dart';
import 'package:wattkeeperr/controllers/DeviceController.dart';
import 'package:wattkeeperr/models/Device.dart';

class DevicesBuilder extends StatefulWidget {
  String token;
  DevicesBuilder({
    super.key,
    required this.token,
  });

  @override
  State<DevicesBuilder> createState() => _DevicesBuilderState();
}

class _DevicesBuilderState extends State<DevicesBuilder> {
  List<Device> dispositivos = [];
  final controller = DeviceController();
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
        dispositivos = await controller.getDevicesUser(widget.token);
      });
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
        ? ErrorScreen(reload: handleRefresh)
        : isInitialize 
          ? (dispositivos.isNotEmpty 
              ? 
              
              GridView.builder(
            padding: const EdgeInsets.symmetric(vertical: 10),
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, crossAxisSpacing: 8.0, mainAxisSpacing: 8.0),
            itemCount: dispositivos.length,
            itemBuilder: (context, index) {
               return DeviceCard(
                          device: dispositivos[index],
                          token: widget.token,
                          reload: handleRefresh,
                        );
            })
               : NonDevices(
            message: "No hay dispositivos vinculados a esta cuenta",
            token: widget.token,
          )
              ) : LoadingAnimation();
   /*  List<Widget> dispositivosWidget = dispositivos
        .map((e) => DeviceCard(
              device: e,
              token: widget.token,
              reload: handleRefresh,
            ))
        .toList();
    return dispositivos.isNotEmpty
        ? GridView.builder(
            padding: const EdgeInsets.symmetric(vertical: 10),
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, crossAxisSpacing: 8.0, mainAxisSpacing: 8.0),
            itemCount: dispositivosWidget.length,
            itemBuilder: (context, index) {
              return dispositivosWidget[index];
            })
        : NonDevices(
            message: "No hay dispositivos vinculados a esta cuenta",
            token: widget.token,
          ); */
  }
}
