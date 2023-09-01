import 'package:SentinelVPN/helpers/pref.dart';
import 'package:SentinelVPN/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

//global object for accessing device screen size
late Size sz;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //enter full-screen
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
  await Pref.intializeHive();

  //for setting orientation to portrait only
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]).then((v) {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    sz = MediaQuery.of(context).size;
    return GetMaterialApp(
      title: 'Sentinel VPN',
      //theme
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          centerTitle: true,
          elevation: 3,
          color: Color(0xFFBEFC8D),
        ),
      ),
      themeMode: Pref.isDarkMode ? ThemeMode.dark : ThemeMode.light,
      //dark theme
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        appBarTheme: AppBarTheme(
          centerTitle: true,
          elevation: 3,
        ),
      ),
      home: SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

extension AppTheme on ThemeData {
  Color get lightText => Pref.isDarkMode ? Colors.white70 : Colors.black54;
  Color get bottomNav => Pref.isDarkMode ? Colors.white12 : Color(0xFFBEFC8D);
}
