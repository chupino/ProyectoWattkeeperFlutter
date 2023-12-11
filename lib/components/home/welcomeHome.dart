import 'package:flutter/material.dart';
import 'package:wattkeeperr/models/User.dart';

class WelcomeHome extends StatelessWidget {
  final User user;
  const WelcomeHome({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Theme.of(context).primaryColor,
      ),
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: RichText(
                text: TextSpan(children: [
                  TextSpan(
                    text: "Bienvenido de nuevo, ",
                    style: Theme.of(context).textTheme.titleMedium
                  ),
                  TextSpan(
                    text: user.nombres,
                    style: Theme.of(context).textTheme.titleLarge
                  )
                ]),
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.notifications,
                size: 40,
              ),
            )
          ],
        ),
      ),
    );
  }
}
