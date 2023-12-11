import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wattkeeperr/components/settings/switchCustom.dart';
import 'package:wattkeeperr/components/settings/tileCustom.dart';
import 'package:wattkeeperr/controllers/ThemeController.dart';
import 'package:wattkeeperr/pages/accountPage.dart';
import 'package:wattkeeperr/providers/ThemeProvider.dart';

class SettingsPage extends StatefulWidget {
  final String token;
  const SettingsPage({super.key, required this.token});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final controller = ThemeController();



  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ThemeProvider>(context);
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TileCustom(
            icon: Icons.dark_mode,
            title: "Modo Oscuro",
            widgetAdj: Consumer<ThemeProvider>(
              builder: (context, notifier, child) => SwitchCustom(
                value: notifier.darkTheme,
                onToggle: (value) async {
                  provider.toggleTheme();

                  await ThemeController().changeTheme(value);
                },
                activeIcon: Icons.dark_mode,
                inactiveIcon: Icons.sunny,
              ),
            ),
          ),
          Divider(),
          TileCustom(
            icon: Icons.account_circle_sharp,
            title: "Cuenta",
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AccountPage(token: widget.token)));
            },
          ),
          
        ],
      ),
    ));
  }
}
