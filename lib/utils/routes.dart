import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wattkeeperr/components/navBar/navBar.dart';
import 'package:wattkeeperr/pages/loginPage.dart';
import 'package:wattkeeperr/pages/onBoardingPage.dart';
import 'package:wattkeeperr/pages/registerPage.dart';

class Routes {
  Future<String> getInitialRoute() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getBool('onBoardSkip') == true) {
      if (prefs.getBool('isLogged') == true) {
        return '/navBarHome';
      } else {
        return '/login';
      }
    } else {
      return '/onBoarding';
    }
  }

  static final Map<String, Widget Function(BuildContext)> routesNative = {
    '/navBarHome': (context) => NavBarWattKeeper(initialIndex: 0),
    '/login': (context) => LoginPage(),
    '/register': (context) => RegisterPage(),
    '/onBoarding' : (context) => OnBoardingPage()
  };
}
