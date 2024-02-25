import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:malo_ivoire_app/screens/SplashScreen.dart';
import 'package:malo_ivoire_app/screens/homes/home_page.dart';
import 'package:malo_ivoire_app/widgets/splash.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: "Montserrat",
        primarySwatch: Colors.blue,
      ),
      // home: const SplashWidget(
      //   child: SplashScreen(),
      // ),
      home: HomePage()
    );
  }
}
