import 'dart:async';

import 'package:flutter/material.dart';
import 'package:malo_ivoire_app/config/function.dart';
import 'package:malo_ivoire_app/screens/firt-page.dart';
import 'package:malo_ivoire_app/screens/homes/home_page.dart';

import 'package:shared_preferences/shared_preferences.dart';

class SplashWidget extends StatefulWidget {
  const SplashWidget({
    super.key,
    this.time = 2,
    required this.child,
  });
  final int time;
  final Widget child;

  @override
  State<SplashWidget> createState() => _SplashWidgetState();
}

class _SplashWidgetState extends State<SplashWidget> {
  // l'utilisateur ne sait pas encors connecter
  String connectUser = "false";
  @override
  void initState() {
    super.initState();
    checkLoginUserConnect();
  }

  void checkLoginUserConnect() async {
    //Ici, nous verifions si l'utilisateur est deja connecté ou si les informationd'identifications sont deja disponible
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? val = pref.getString('token');

    if (val != null) {
      print(val);
      setState(() {
        connectUser = "true";
        print(connectUser);
      });
    } else {
      print("l'utilisateur n'est pas connecter");
    }
  }

  @override
  Widget build(BuildContext context) {
    Timer(Duration(seconds: widget.time), () {
      route(context, connectUser == "false" ? FirtPage() : HomePage(),
          close: true);
    });
    return widget.child;
  }
}
