import 'package:flutter/material.dart';
import 'package:wattkeeperr/components/home/homeScheme.dart';

class HomePage extends StatelessWidget {
  final String token;

  const HomePage({required this.token, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: HomeScheme(token: token)));
  }
}
