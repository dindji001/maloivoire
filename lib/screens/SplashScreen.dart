import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:malo_ivoire_app/config/config.dart';
import 'package:malo_ivoire_app/config/function.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isConnected = false;

  @override
  void initState() {
    super.initState();
    checkInternetConnection();
  }

  Future<void> checkInternetConnection() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      // Pas de connexion Internet
      setState(() {
        isConnected = false;
      });
    } else {
      // Connexion Internet disponible
      setState(() {
        isConnected = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: 10,
          ),
          Image.asset(
            Config.asset.logo,
            width: width(context) * 0.9,
          ),
          FutureBuilder(
            future: checkInternetConnection(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator(
                  color: Config.colors.secondaryColor,
                );
              } else if (!isConnected) {
                return Text(
                  "Pas de connexion Internet",
                  style: TextStyle(color: Colors.red),
                );
              } else {
                // Vous pouvez passer à l'écran suivant ici
                // ou effectuer d'autres actions en cas de connexion Internet disponible.
                return SizedBox(); // Renvoyez un widget vide pour ne rien afficher.
              }
            },
          ),
        ],
      ),
    );
  }
}
