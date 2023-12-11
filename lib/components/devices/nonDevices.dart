import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:wattkeeperr/pages/linkDevice.dart';

class NonDevices extends StatelessWidget {
  final String message;
  final String token;
  const NonDevices({super.key, required this.message, required this.token});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(20),
      ),
      padding: EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            children: [
              Lottie.asset('assets/animations/void.json', height: 100),
              Flexible(
                child: Text(
                  message,
                ),
              )
            ],
          ),
          Row(
            children: [
              Expanded(
                  child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => LinkDevicePage(token: token)));
                },
                child: Text('Vincular uno'),
              )),
            ],
          )
        ],
      ),
    );
  }
}
