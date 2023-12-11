import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:wattkeeperr/components/devices/deviceBuilder.dart';
import 'package:wattkeeperr/components/loading/loadingAnimation.dart';
import 'package:wattkeeperr/controllers/DeviceController.dart';
import 'package:wattkeeperr/models/Device.dart';



class DevicesPage extends StatelessWidget {

final String token;

 const DevicesPage({super.key, required this.token});

  @override
  Widget build(BuildContext context) {
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
                  DevicesBuilder(token: token)
          ],
        ),
      )
      
      /* RefreshIndicator(
        onRefresh: handleRefresh,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            isInitialize
                ? DevicesBuilder(
                    token: widget.token,
                    devices: devices,
                    handleRefresh: handleRefresh,
                  )
                : LoadingAnimation()
          ],
        ),
      ), */
    ));
  }
}
