import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:wattkeeperr/components/devices/deviceHeader.dart';
import 'package:wattkeeperr/components/groups/headerGroup.dart';
import 'package:wattkeeperr/components/home/headerHome.dart';
import 'package:wattkeeperr/components/navBar/header.dart';
import 'package:wattkeeperr/components/navBar/items.dart';
import 'package:wattkeeperr/components/settings/settingsHeader.dart';
import 'package:wattkeeperr/controllers/SessionController.dart';
import 'package:wattkeeperr/pages/devicesPage.dart';
import 'package:wattkeeperr/pages/groupsPage.dart';
import 'package:wattkeeperr/pages/homePage.dart';
import 'package:wattkeeperr/pages/settingsPage.dart';

class NavBarWattKeeper extends StatefulWidget {
  final int initialIndex;

  const NavBarWattKeeper({Key? key, required this.initialIndex}) : super(key: key);

  @override
  State<NavBarWattKeeper> createState() => _NavBarWattKeeperState();
}

class _NavBarWattKeeperState extends State<NavBarWattKeeper> {
  int _currentIndex = 0;
  int dummy = 0;
  final controller = SessionController();
  String token = "";

  void _updateIndex(int newIndex) {
    setState(() {
      _currentIndex = newIndex;
    });
  }

  bool isInitialized = false;
  Future<void> initAsync() async {
    token = await controller.getToken();
    print(token);
    setState(() {
      isInitialized = true;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initAsync();
    _currentIndex = widget.initialIndex;
  }

  Widget _buildSliverAppBar() {
    switch (_currentIndex) {
      case 0:
        return HeaderHome(
          token: token,
        );
      case 1:
        return HeaderGroup(
          token: token,
        );
      case 2:
        return DeviceHeader(
          token: token,
        );
      case 3:
        return SettingsHeader();
      default:
        return SliverAppBar(
          leading: IconButton(
            onPressed: () {},
            icon: Icon(Icons.menu),
          ),
          title: Text("Large App Bar - Página por defecto"),
          actions: [
            IconButton(onPressed: () {}, icon: Icon(Icons.more_vert)),
          ],
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: SalomonBottomBar(
        backgroundColor:
            Theme.of(context).bottomNavigationBarTheme.backgroundColor,
        selectedItemColor:
            Theme.of(context).bottomNavigationBarTheme.selectedItemColor,
        unselectedItemColor:
            Theme.of(context).bottomNavigationBarTheme.unselectedItemColor,
        items: NavBarItems.items,
        currentIndex: _currentIndex,
        onTap: (i) => setState(
          () => _currentIndex = i,
        ),
      ),
      body: isInitialized
          ? Scaffold(
              body: NestedScrollView(
                headerSliverBuilder:
                    (BuildContext context, bool innerBoxIsScrolled) {
                  return [
                    _buildSliverAppBar(),
                  ];
                },
                body: IndexedStack(
                  index: _currentIndex,
                  children: [
                    HomePage(
                      token: token,
                    ),
                    GroupsPage(
                      token: token,
                    ),
                    DevicesPage(
                      token: token,
                    ),
                    SettingsPage(
                      token: token,
                    )
                  ],
                ),
              ),
            )
          : Container(),
    );
  }
}
