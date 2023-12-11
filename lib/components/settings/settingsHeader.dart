import 'package:flutter/material.dart';

class SettingsHeader extends StatelessWidget {
  const SettingsHeader({super.key});

  @override
  Widget build(BuildContext context) {
        return SliverAppBar(
      elevation: 0.0,
      leading: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Icon(
          Icons.settings,
        ),
      ),
      
      title: Text("Ajustes",
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
              color: const Color.fromARGB(255, 220, 220, 220),
              letterSpacing: 1,
              fontWeight: FontWeight.bold)),
      pinned: false,
    );
  }
}