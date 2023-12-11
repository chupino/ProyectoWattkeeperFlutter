import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class ErrorScreen extends StatelessWidget {
  final Function() reload;
  const ErrorScreen({super.key, required this.reload});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Lottie.asset('assets/animations/error.json', repeat: false),
          Text(
            "Ooops, algo salio mal",
            style: Theme.of(context).textTheme.headlineLarge,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            child: Expanded(
              child:
                  ElevatedButton(onPressed: reload, child: Text("Reintentar")),
            ),
          )
        ],
      ),
    );
  }
}
