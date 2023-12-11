import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class NavBarItems{
  static final List<SalomonBottomBarItem> items = [
    SalomonBottomBarItem(
      icon: const Icon(
        FontAwesomeIcons.house,
      ),
      title: const Text(
        "Inicio",
      ),
    ),
    SalomonBottomBarItem(
      icon: const Icon(
        // ignore: deprecated_member_use
        Icons.group,
      ),
      title: const Text("Grupos"),
    ),
    SalomonBottomBarItem(
      icon: const Icon(
        Icons.devices_other_sharp,
      ),
      title: const Text("Dispositivos"),
    ),
    SalomonBottomBarItem(
      icon: const Icon(
        Icons.settings,
      ),
      title: const Text("Ajustes"),
    ),
  ];

}