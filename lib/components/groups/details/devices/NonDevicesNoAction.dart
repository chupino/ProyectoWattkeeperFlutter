import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class NonDevicesNoAction extends StatelessWidget {
  final String message;
  const NonDevicesNoAction({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(20),
      ),
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Lottie.asset('assets/animations/void.json'),
          Text(
            message,
            textAlign: TextAlign.center,
            style:
                Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 18),
          ),
        ],
      ),
    );
  }
}
