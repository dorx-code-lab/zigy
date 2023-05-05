import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:zigy/services/services.dart';

import 'constants/constants.dart';
import 'models/models.dart';
import 'views/views.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox(AppSettings.BOXNAME);
  await Hive.openBox(AppSettings.SEARCHHISTORY);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: capitalizedAppName,
      theme: ThemeData(
        primarySwatch: primaryColor,
        inputDecorationTheme: InputDecorationTheme(
          contentPadding: EdgeInsets.only(
            top: 10,
            bottom: 10,
            left: 10,
            right: 10,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
        ),
      ),
      navigatorKey: NavigationService.navigatorKey,
      home: SplashScreenView(),
    );
  }
}
