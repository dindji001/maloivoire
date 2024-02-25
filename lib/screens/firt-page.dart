import 'package:flutter/material.dart';
import 'package:malo_ivoire_app/config/config.dart';
import 'package:malo_ivoire_app/config/function.dart';
import 'package:malo_ivoire_app/screens/auth/login-page.dart';
import 'package:malo_ivoire_app/screens/auth/register-page.dart';
import 'package:malo_ivoire_app/widgets/button.dart';

class FirtPage extends StatelessWidget {
  const FirtPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: height(context),
            width: width(context),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(Config.asset.champs),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            height: height(context),
            width: width(context),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                stops: [
                  0.1,
                  1,
                ],
                colors: [
                  Color.fromARGB(169, 53, 121, 49),
                  Color.fromARGB(150, 242, 147, 4)
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          Center(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.transparent,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      Container(
                        height: 200,
                        width: 300,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(Config.asset.logo),
                              fit: BoxFit.cover),
                        ),
                      ),
                      Text(
                        "Commandez Votre Riz Local Préféré en Quelques Clics !",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Config.colors.whithColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: width(context) * 0.9,
                    child: Column(
                      children: [
                        Text(
                          textAlign: TextAlign.center,
                          "Goûtez l'Authenticité Locale : Découvrez Notre Riz de Qualité ",
                          style: TextStyle(
                              fontSize: 25, color: Config.colors.whithColor),
                        ),
                        Text(
                          textAlign: TextAlign.center,
                          "Exceptionnelle",
                          style: TextStyle(
                              fontSize: 25,
                              color: Config.colors.secondaryColor),
                        )
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      CButton(
                        title: "Inscription",
                        color: Config.colors.secondaryColor,
                        titleColor: Config.colors.whithColor,
                        onPressed: () {
                          route(context, RegisterPage());
                        },
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      CButton(
                        title: "Connexion",
                        color: Config.colors.primaryColor,
                        titleColor: Config.colors.whithColor,
                        onPressed: () {
                          route(context, LoginPage(), close: true);
                        },
                      )
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
// CButton(title: "Connexion", onPressed: () {})
