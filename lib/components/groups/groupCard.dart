import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:wattkeeperr/components/groups/tags/tagPlan.dart';
import 'package:wattkeeperr/components/groups/tags/tagUsers.dart';
import 'package:wattkeeperr/core/constants/urls.dart';
import 'package:wattkeeperr/models/Group.dart';
import 'package:wattkeeperr/pages/groupDetails.dart';
import 'package:web_socket_channel/io.dart';

class GroupCard extends StatefulWidget {
  final Group group;
  final String token;
  const GroupCard({super.key, required this.group, required this.token});

  @override
  State<GroupCard> createState() => _GroupCardState();
}

class _GroupCardState extends State<GroupCard> {
  late final IOWebSocketChannel channel;
  streamListener() {
    channel.stream.listen((message) {
      final data = jsonDecode(message);
      setState(() {
        consumo = data["message"];
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    channel = IOWebSocketChannel.connect(
        '${Urls.webSocketDjango}/ws/wk/${widget.token}/devices/${widget.group.id}');
    streamListener();
  }

  String consumo = "0";
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => GroupDetailPage(
                    groupId: widget.group.id, token: widget.token)));
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Theme.of(context).primaryColor,
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          widget.group.nombre,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ),
                      Wrap(
                        alignment: WrapAlignment.end,
                        runAlignment: WrapAlignment.end,
                        children: [
                          TagUsers(users: widget.group.usuarios.length),
                          SizedBox(
                            width: 2,
                          ),
                          TagPlan(hasPlan: true)
                        ],
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Column(
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.energy_savings_leaf,
                            size: 70,
                            color: Color.fromARGB(255, 203, 180, 96),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Consumo',
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                              Text("${consumo}W",
                                  style: Theme.of(context).textTheme.bodyLarge)
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.devices,
                            size: 30,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text.rich(TextSpan(
                              text: "${widget.group.dispositivos.length}",
                              style: Theme.of(context).textTheme.bodyLarge,
                              children: [
                                TextSpan(
                                    text: " dispositivos",
                                    style:
                                        Theme.of(context).textTheme.bodySmall)
                              ]))
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.health_and_safety,
                            size: 30,
                            color: widget.group.limiteConsumo != 0
                                ? Colors.green
                                : Colors.red,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(widget.group.limiteConsumo != 0
                              ? 'Plan de Ahorro'
                              : 'Sin Plan')
                        ],
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => GroupDetailPage(
                                          groupId: widget.group.id,
                                          token: widget.token)));
                            },
                            child: Text('Ver')),
                      )
                    ],
                  ),
                ],
              )),
            ],
          ),
        ),
      ),
    );
  }
}
