import 'package:flutter/material.dart';

class HeaderNavBar extends StatelessWidget {
  const HeaderNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return const SliverAppBar(
      elevation: 0.0,
      title: Padding(
        padding: EdgeInsets.symmetric(vertical: 50),
        child: Center(
            child: Text(
          "WattsKeeper",
        )),
      ),
      pinned: true,
    );
  }
}
