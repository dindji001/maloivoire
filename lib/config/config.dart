import 'package:flutter/material.dart';

class Config {
  static final colors = _Color();
  static final asset = _Asset();
}

class _Color {
  final primaryColor = Color(0xFFF29104);
  final secondaryColor = Color(0xFF357931);
  final roseColor = Color(0xFFE84E1B);
  final grayColor = Color(0xFFB1B1B1);
  final whithColor = Color(0xffFFFFFF);
  final textColor = Color(0xFF1D1D1B);
  final backgroundTextField = Color.fromARGB(75, 177, 177, 177);
  final backgroundTextField2 = Color.fromARGB(108, 255, 153, 0);
  final blockBtn = Color.fromARGB(120, 196, 127, 17);
}

class _Asset {
  final logo = "assets/images/logo.png";
  final champs = "assets/images/champs.jpeg";
  final profil = "assets/images/profil.png";
  final consommer = "assets/images/consommer.jpeg";
  final rizLocal = "assets/images/rizLocal.jpeg";
  final rizLocalPng = "assets/images/rizLocal.png";
  final orangeMoney = "assets/images/orange.png";
  final mtnMoney = "assets/images/MTN.jpg";
  final moovMoney = "assets/images/moov.jpg";
  final sacRiz5x5 = "assets/images/Sac-de-riz-local-parfumé-Malo-5x5kg.jpeg";
  final sacRiz25 = "assets/images/Sac-de-riz-local-parfumé-Malo-25kg.jpg";
  final sacRiz50 = "assets/images/Sac-de-riz-local-parfumé-Malo-50kg.jpg";
  final sacRiz5 = "assets/images/Sac-de-riz-local-parfumé-Malo-5kg.jpeg";
}

class RadioTitleListeItem {
  String value;
  bool isSelectedRadio;
  RadioTitleListeItem(this.value, this.isSelectedRadio);
}
