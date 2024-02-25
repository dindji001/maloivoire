import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:malo_ivoire_app/config/config.dart';
import 'package:malo_ivoire_app/config/function.dart';
import 'package:intl/intl.dart';
import 'package:malo_ivoire_app/screens/command/preCommander.dart';
import 'package:malo_ivoire_app/screens/payement/payement_page.dart';

import 'package:malo_ivoire_app/widgets/button.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CommandeRiz extends StatefulWidget {
  final String productName;
  final String categorieName;
  final String productPrice;
  final String productImage;
  final String poidKg;
  const CommandeRiz({
    super.key,
    required this.productName,
    required this.productPrice,
    required this.productImage,
    required this.categorieName,
    required this.poidKg,
  });

  @override
  State<CommandeRiz> createState() => _CommandeRizState();
}

class _CommandeRizState extends State<CommandeRiz> {
  int prixRiz = 0;
  int prixTotal = 0;
  String _itemPriceTotalConvert = "";
  int _itemPriceTotal = 0;
  String user_phone = "";
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  final snackBar = SnackBar(
    content: const Text('La commande maximum est 9'),
    action: SnackBarAction(
      label: 'Fermer',
      onPressed: () {
        // Some code to undo the change.
      },
    ),
  );

  String ajouterEspaces(int chiffres) {
    String chiffresStr = chiffres.toString();
    String chiffresAvecEspaces = '';

    int index = chiffresStr.length;
    while (index > 0) {
      int debut = (index - 3).clamp(0, index);
      String groupe = chiffresStr.substring(debut, index);
      chiffresAvecEspaces = '$groupe $chiffresAvecEspaces';
      index = debut;
    }

    chiffresAvecEspaces = chiffresAvecEspaces.trim();

    return chiffresAvecEspaces;
  }

  int _counter = 1;

  DateTime dateChose = DateTime.now();

  @override
  void initState() {
    super.initState();
    final String prix = widget.productPrice;
    // ignore: unused_local_variable
    int prixSacRiz = int.parse(prix);
    CallToNumberPhone();
    setState(() {
      prixRiz = prixSacRiz;
    });
  }
  void CallToNumberPhone() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      user_phone = pref.getString("user_phone")!;
    });
  }

  void _livraison() {}

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _decrementCounter() {
    setState(() {
      _counter--;
    });
  }

  String _calculatePrice() {
    _itemPriceTotal = prixRiz * _counter;
    setState(() {
      prixTotal = _itemPriceTotal;
    });
    return _itemPriceTotalConvert = ajouterEspaces(_itemPriceTotal);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Config.colors.secondaryColor,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          widget.categorieName,
          style: TextStyle(
              color: Config.colors.textColor,
              fontSize: 14,
              fontWeight: FontWeight.bold),
        ),
        elevation: 0,
        backgroundColor: Config.colors.whithColor,
        iconTheme: IconThemeData(color: Config.colors.secondaryColor),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Stack(
            children: [
              Container(
                width: width(context),
                height: height(context) * 0.76,
                decoration: BoxDecoration(
                  color: Config.colors.whithColor,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding:
                            const EdgeInsets.only(right: 10, left: 10, top: 30),
                        child: Column(
                          children: [
                            Container(
                              height: height(context) * 0.33,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(
                                      widget.productImage,
                                    ),
                                    fit: BoxFit.contain),
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      right: 10, left: 10, top: 20),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          widget.categorieName,
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          IconButton(
                                            onPressed: () {
                                              _decrementCounter();
                                            },
                                            icon: Icon(
                                              Icons.do_not_disturb_on_rounded,
                                              size: 40,
                                              color:
                                                  Config.colors.secondaryColor,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            '$_counter',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          IconButton(
                                            onPressed: () {
                                              _incrementCounter();
                                            },
                                            icon: Icon(
                                              Icons.add_circle,
                                              size: 40,
                                              color:
                                                  Config.colors.secondaryColor,
                                            ),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(right: 10, left: 10, top: 30),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.monetization_on_rounded,
                                      size: 30,
                                      color: Config.colors.backgroundTextField,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      "Prix",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color:
                                            Config.colors.backgroundTextField,
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  ' ${_calculatePrice()}' + " FCFA",
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: Config.colors.secondaryColor,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.local_shipping_rounded,
                                      size: 30,
                                      color: Config.colors.backgroundTextField,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      "Livraison",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color:
                                            Config.colors.backgroundTextField,
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  // ' ${_livrason()}' + " FCFA",
                                  '0' + " FCFA",
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: Config.colors.secondaryColor,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Date de livraison",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime.now(),
                                      lastDate: DateTime(3000),
                                    ).then((value) {
                                      if (value == null) {
                                        return;
                                      }
                                      setState(() {
                                        dateChose = value;
                                      });
                                    });
                                  },
                                  child: Text(
                                    "${DateFormat('dd-MM-yyyy').format(dateChose)}",
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: Config.colors.secondaryColor,
                                        fontWeight: FontWeight.bold),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Prix Total:",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Config.colors.whithColor),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      ' ${_calculatePrice()}' + " FCFA",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: Config.colors.whithColor),
                    )
                  ],
                ),
                CButton(
                  title: "Pre-Commamder ",
                  sizeTitle: 12,
                  onPressed: () {
                    // route(
                    //   context,
                    //   payementPage(
                    //     totalPrice: prixTotal,
                    //     deliveryPrice: 0,
                    //     quantityOrder: _counter,
                    //     priceOrder: prixTotal,
                    //   ),
                    //
                    // );
                    Get.bottomSheet(
                      PayementButtonSheetPrecommander(
                        prixTotal: prixTotal,
                        numberPhne: user_phone,
                        deliveryPrice: 0,
                        quantity_order: _counter,
                        order_price: _itemPriceTotal,

                      ),
                    );
                  },
                  width: width(context) * 0.35,
                  color: Config.colors.whithColor,
                  titleColor: Config.colors.secondaryColor,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
