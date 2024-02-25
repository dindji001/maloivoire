import 'package:flutter/material.dart';
import 'package:malo_ivoire_app/config/config.dart';
import 'package:malo_ivoire_app/config/function.dart';
import 'package:malo_ivoire_app/screens/riz-normal/riz_normal.dart';
import 'package:malo_ivoire_app/widgets/button.dart';
import 'package:malo_ivoire_app/widgets/textField.dart';

class BodyHomePage extends StatefulWidget {
  const BodyHomePage({Key? key}) : super(key: key);

  @override
  State<BodyHomePage> createState() => _BodyHomePageState();
}

class _BodyHomePageState extends State<BodyHomePage> {
  final snackBarIncrement = SnackBar(
    content: const Text("Cette categorie de riz n'est pas disponible"),
    action: SnackBarAction(
      label: 'Annuler',
      onPressed: () {
        // Some code to undo the change.
      },
    ),
  );
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      // Utilisez SingleChildScrollView pour éviter le dépassement de la hauteur de l'écran
      child: Column(
        children: [
          Container(
            height: 270,
            decoration: BoxDecoration(
              color: Config.colors.secondaryColor,
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(15),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(right: 5.0, top: 20, left: 5),
              child: Column(
                children: [
                  CtextField(
                    height: 55,
                    hint: "Recherche catégorie de riz...",
                    backgroundColor: Config.colors.whithColor,
                    raduis: 30,
                    prefixIcon: Icon(
                      Icons.search,
                    ),
                    validator: (value) {},
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    height: 160,
                    width: width(context),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      image: DecorationImage(
                        image: AssetImage(
                          Config.asset.consommer,
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Categorie de riz",
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Config.colors.textColor,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            height: 200,
            width: width(context),
            decoration: BoxDecoration(
              color: Color.fromARGB(55, 242, 147, 4),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 5.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          "Riz Normal",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          "Optez pour le riz local normal, savoureux et idéal pour les repas en famille.",
                          style: TextStyle(color: Config.colors.grayColor),
                        ),
                        CButton(
                          title: "Voir plus",
                          sizeTitle: 14,
                          onPressed: () {
                            route(context, RizNormal());
                          },
                        )
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(Config.asset.rizLocalPng),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Container(
            height: 200,
            width: width(context),
            decoration: BoxDecoration(
              color: Color.fromARGB(36, 53, 121, 49),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 5.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          "Riz Diébétique",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          "Le riz local, à faible indice glycémique, est un choix idéal pour les diabétiques.",
                          style: TextStyle(color: Config.colors.grayColor),
                        ),
                        CButton(
                          title: "Voir plus",
                          color: Config.colors.secondaryColor,
                          sizeTitle: 14,
                          onPressed: () {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBarIncrement);
                          },
                        )
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(Config.asset.rizLocalPng),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Container(
            height: 300,
            width: width(context),
            decoration: BoxDecoration(
              color: Color.fromARGB(47, 232, 78, 27),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 5.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          "Riz Autre variété",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          "Découvrez la diversité des variétés de riz local, chacune offrant une expérience gustative unique. Du riz complet, avec sa richesse nutritionnelle, au riz parfumé, embaumant la cuisine de ses arômes, notre sélection de riz local répond à toutes les préférences culinaires, ajoutant une touche locale et authentique à vos repas.",
                          style: TextStyle(
                              color: Config.colors.grayColor, fontSize: 10),
                        ),
                        CButton(
                          title: "Voir plus",
                          color: Config.colors.roseColor,
                          sizeTitle: 14,
                          onPressed: () {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBarIncrement);
                          },
                        )
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(Config.asset.rizLocalPng),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
