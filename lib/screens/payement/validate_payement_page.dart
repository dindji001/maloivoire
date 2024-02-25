import 'package:flutter/material.dart';
import 'package:malo_ivoire_app/config/config.dart';
import 'package:malo_ivoire_app/config/function.dart';
import 'package:malo_ivoire_app/screens/homes/home_page.dart';
import 'package:malo_ivoire_app/widgets/button.dart';

class ValidatePayementPage extends StatefulWidget {
  const ValidatePayementPage({super.key});

  @override
  State<ValidatePayementPage> createState() => _ValidatePayementPageState();
}

class _ValidatePayementPageState extends State<ValidatePayementPage> {
  late String? Operateur = "";

  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: CButton(
        color: Config.colors.secondaryColor,
        width: width(context) * 0.9,
        title: "Continuer la commande",
        onPressed: () {
          route(context, const HomePage(), close: true);
        },
        titleColor: Config.colors.whithColor,
      ),
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            route(
              context,
              const HomePage(),
              close: true,
            );
          },
          icon: Icon(Icons.home),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: Config.colors.secondaryColor),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
              ),
              child: Icon(
                Icons.help_outlined,
                size: 85,
                color: Config.colors.secondaryColor,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              textAlign: TextAlign.center,
              "Commande en attente de livraison",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Text(
                    textAlign: TextAlign.center,
                    " Pour valider votre transaction, vous devez composer sur votre téléphone",
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    Operateur == 'MtnCI'
                        ? "*133#"
                        : Operateur == 'MoovCI'
                            ? "*155#"
                            : "#144*8*2#",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  Text(
                    "puis Séléctionner l'option retrait.",
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    "La commande séra faite +2 jours de la date choisir lors de la commande",
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
