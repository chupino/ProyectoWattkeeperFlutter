import 'package:flutter/material.dart';
import 'package:wattkeeperr/pages/joinGroupPage.dart';

class JoinGroupSection extends StatelessWidget {
  final String token;
  const JoinGroupSection({super.key, required this.token});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => JoinGroupPage(token: token)));
      },
      child: Row(
        children: [
          const Icon(
            Icons.add,
            size: 50,
          ),
          const SizedBox(
            width: 20,
          ),
          Text(
            "Unirse",
            style: Theme.of(context).textTheme.bodyLarge,
          )
        ],
      ),
    );
  }
}
