import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:malo_ivoire_app/config/config.dart';
import 'package:malo_ivoire_app/config/function.dart';
import 'package:malo_ivoire_app/controllers/price_riz_normal.dart';
import 'package:malo_ivoire_app/screens/command/demi_gros.dart';
import 'package:malo_ivoire_app/widgets/produit_card.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RizNormal extends StatefulWidget {
  const RizNormal({super.key});

  @override
  State<RizNormal> createState() => _RizNormalState();
}

class _RizNormalState extends State<RizNormal> {
  int? quantity_disponible_5kg = 0;
  int? prix_5kg = 0;
  int? prix_25kg = 0;
  int? prix_50kg = 0;
  int? prix_5x5kg = 0;

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  RizNomalInfoController rizNomalInfoController = Get.put(
    RizNomalInfoController(),
  );

  void initState() {
    super.initState();
    getInfoRizNormal();
  }

  getInfoRizNormal() async {
    rizNomalInfoController.getPriceGategoryFunction();
    SharedPreferences prefs = await _prefs;
    final subCategoryPrice5kg =
        int.parse(prefs.getString('sub_category_price_5kg')!);
    final subCategoryPrice25kg =
        int.parse(prefs.getString('sub_category_price_25kg')!);
    final subCategoryPrice50kg =
        int.parse(prefs.getString('sub_category_price_50kg')!);
    final subCategoryPrice5x5kg =
        int.parse(prefs.getString('sub_category_price_5x5kg')!);
    final subCategoryQte5kg =
        int.parse(prefs.getString('sub_category_qte_5kg')!);
    setState(() {
      prix_5kg = subCategoryPrice5kg;
      prix_25kg = subCategoryPrice25kg;
      prix_50kg = subCategoryPrice50kg;
      prix_5x5kg = subCategoryPrice5x5kg;
      quantity_disponible_5kg = subCategoryQte5kg;
    });
    print(prix_5kg);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Rz normal",
          style: TextStyle(
            fontSize: 16,
            color: Config.colors.secondaryColor,
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(
          color: Config.colors.secondaryColor,
        ),
      ),
      body: GridView.count(
        mainAxisSpacing: 1, crossAxisSpacing: 0,
        childAspectRatio: 0.65,
        shrinkWrap:
            true, // Ajout de cette ligne pour que la grille s'adapte au contenu
        physics:
            NeverScrollableScrollPhysics(), // Ajout de cette ligne pour désactiver le défilement
        crossAxisCount: 2, // 2 produits par ligne
        children: <Widget>[
          GestureDetector(
            onTap: () {
              route(
                  context,
                  CommandeRiz(
                    productImage: Config.asset.sacRiz25,
                    productName: 'Riz étuvé',
                    productPrice: '${prix_25kg}',
                    categorieName: 'Riz normal 25kg',
                    poidKg: '25',
                  ));
            },
            child: ProductCard(
              'Sac 25Kg',
              '${prix_25kg}' + " FCFA",
              Config.asset.sacRiz25,
            ),
          ),
          GestureDetector(
            onTap: () {
              route(
                  context,
                  CommandeRiz(
                    productImage: Config.asset.sacRiz50,
                    productName: 'Sac 50Kg',
                    productPrice: '${prix_50kg}',
                    categorieName: 'Rir normal 50kg',
                    poidKg: '50',
                  ));
            },
            child: ProductCard(
              'Sac 50Kg',
              '${prix_50kg} FCFA',
              Config.asset.sacRiz50,
            ),
          ),
          GestureDetector(
            onTap: () {
              route(
                  context,
                  CommandeRiz(
                    productImage: Config.asset.sacRiz5,
                    productName: 'Sac 5Kg',
                    productPrice: '${prix_5kg}',
                    categorieName: 'Rir normal 5kg',
                    poidKg: '5',
                  ));
            },
            child: ProductCard(
              'Sac 5Kg',
              '${prix_5kg} FCFA',
              Config.asset.sacRiz5,
            ),
          ),
          GestureDetector(
            onTap: () {
              route(
                  context,
                  CommandeRiz(
                    productImage: Config.asset.sacRiz5x5,
                    productName: 'Sac 25Kg (5x5)',
                    productPrice: '${prix_5x5kg}',
                    categorieName: 'Rir normal 25kg (5x5)',
                    poidKg: '25',
                  ));
            },
            child: ProductCard(
              'Sac 25Kg (5x5)',
              '${prix_5x5kg} FCFA',
              Config.asset.sacRiz5x5,
            ),
          ),
        ],
      ),
    );
  }
}
