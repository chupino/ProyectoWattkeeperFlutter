import 'package:flutter/material.dart';

class HeaderAccount extends StatelessWidget {
  const HeaderAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return const SliverAppBar(
      elevation: 0.0,
      title: Padding(
        padding: EdgeInsets.all(32.0),
        child: Center(
            child: Text(
          "Cuenta",
        )),
      ),
      pinned: true,
    );
  }
}