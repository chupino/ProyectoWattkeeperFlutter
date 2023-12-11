import 'package:flutter/material.dart';
import 'package:wattkeeperr/pages/joinGroupPage.dart';

class HeaderGroup extends StatelessWidget {
  final String token;
  const HeaderGroup({super.key, required this.token});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      elevation: 0.0,
      leading: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Icon(
          Icons.group,
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => JoinGroupPage(token: token)));
            },
            icon: Icon(
              Icons.add,
            ),
          ),
        )
      ],
      title: Text("Grupos ",
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
              color: const Color.fromARGB(255, 220, 220, 220),
              letterSpacing: 1,
              fontWeight: FontWeight.bold)),
      pinned: false,
    );
  }
}
