import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:wattkeeperr/components/groups/details/tamagochi/recompensaCard.dart';
import 'package:wattkeeperr/core/constants/urls.dart';
import 'package:wattkeeperr/models/GroupDetails.dart';
import 'package:wattkeeperr/models/Medicion.dart';
import 'package:web_socket_channel/io.dart';

class TamagotchiGroupScheme extends StatefulWidget {
  final GroupDetails groupDetails;
  final Future Function() onRefresh;
  final String token;
  const TamagotchiGroupScheme(
      {super.key,
      required this.groupDetails,
      required this.onRefresh,
      required this.token});

  @override
  State<TamagotchiGroupScheme> createState() => _TamagotchiGroupSchemeState();
}

class _TamagotchiGroupSchemeState extends State<TamagotchiGroupScheme> {
  double consumoTotal = 0.0;
  late final IOWebSocketChannel channel;

  void initData() {
    consumoTotal = widget.groupDetails.acumuladoWattsTotal!;
  }

  initChannel() {
    channel = IOWebSocketChannel.connect(
        '${Urls.webSocketDjango}/ws/wk/${widget.token}/grupos/${widget.groupDetails.id}');
  }

  streamListener() {
    channel.stream.listen((message) {
      final data = jsonDecode(message);
      Medicion medicion =
          Medicion.fromJson(data["data"] as Map<String, dynamic>);
      setState(() {
        consumoTotal = consumoTotal + medicion.watts;
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initChannel();
    initData();
    streamListener();
  }

  @override
  Widget build(BuildContext context) {
    var recompensas = <Widget>[];
    if (widget.groupDetails.recompensas.isNotEmpty) {
      recompensas.addAll(widget.groupDetails.recompensas
          .map((e) => RecompensaCard(
                consumoTotal: consumoTotal,
                recompensa: e,
                token: widget.token,
                id: widget.groupDetails.id,
              ))
          .toList());
    } else {
      recompensas.add(Text(
        'No hay recompensas establecidas',
        style: Theme.of(context).textTheme.bodyMedium,
      ));
    }
    return RefreshIndicator(
      onRefresh: widget.onRefresh,
      child: ListView(children: [
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Theme.of(context).primaryColor),
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(widget.groupDetails.getTamagochiDynamicImage()),
              const SizedBox(
                height: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Recompensas:',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ...recompensas,
                ],
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
