import 'package:flutter/material.dart';

class TagUsers extends StatelessWidget {
  final int users;
  const TagUsers({super.key, required this.users});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
          color: Colors.amber, borderRadius: BorderRadius.circular(10)),
      child: Row(
        children: [Text("$users"), Icon(Icons.supervised_user_circle)],
      ),
    );
  }
}
