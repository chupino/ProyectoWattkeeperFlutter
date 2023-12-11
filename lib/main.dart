import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';
import 'package:wattkeeperr/providers/ThemeProvider.dart';
import 'package:wattkeeperr/providers/NotificationsProvider.dart';
import 'package:wattkeeperr/utils/routes.dart';
import 'package:wattkeeperr/utils/themes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  initializeDateFormatting('es');
  final initalRoute = await Routes().getInitialRoute();
  runApp(MainApp(
    initialRoute: initalRoute,
  ));
}

class MainApp extends StatelessWidget {
  final String initialRoute;
  const MainApp({super.key, required this.initialRoute});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
        ChangeNotifierProvider(create: (context) => NotificationsProvider()),
      ],
      child: Consumer<ThemeProvider>(
          builder: (context, ThemeProvider provider, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'WattsKeeper',
          theme: provider.darkTheme ? Themes().darkTheme : Themes().lightTheme,
          routes: Routes.routesNative,
          initialRoute: initialRoute,
        );
      }),
    );
  }
}
