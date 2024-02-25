import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:malo_ivoire_app/config/config.dart';
import 'package:malo_ivoire_app/config/function.dart';
import 'package:malo_ivoire_app/screens/payement/payement_button_sheet.dart';
import 'package:malo_ivoire_app/widgets/button.dart';

class payementPage extends StatefulWidget {
  final int totalPrice;

  final int deliveryPrice;
  final int quantityOrder;
  final int priceOrder;

  const payementPage(
      {super.key,
      required this.totalPrice,
      required this.deliveryPrice,
      required this.quantityOrder,
      required this.priceOrder});

  @override
  State<payementPage> createState() => _payementPageState();
}

class _payementPageState extends State<payementPage> {

  @override
  void initState() {
    super.initState();
  }

  String? payementMethode;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: payementMethode != null
          ? CButton(
              width: width(context) * 0.9,
              title: "Passer au payement",
              color: Config.colors.secondaryColor,
              onPressed: () {
                print(widget.totalPrice);
                Get.bottomSheet(
                  PayementButtonSheet(
                    prixTotal: widget.totalPrice,
                    // idCategorie: widget.idCategorie,
                    deliveryPrice: widget.deliveryPrice,
                    quantity_order: widget.quantityOrder,
                    order_price: widget.priceOrder,
                  ),
                );
                // print("object");
              },
              titleColor: Config.colors.whithColor,
            )
          : CButton(
              color: Config.colors.backgroundTextField,
              width: width(context) * 0.9,
              title: "Passer au payement",
              onPressed: () {

              },
              titleColor: Config.colors.whithColor,
            ),
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Methode de payement",
          style: TextStyle(
              fontSize: 20,
              color: Config.colors.textColor,
              fontFamily: "roboto"),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: Config.colors.secondaryColor),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 10.0, left: 15),
        child: Container(
          height: height(context) * 0.7,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Selectionnez votre Methode de payement",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Ajoutez un nouveau service",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      RadioListTile(
                        title: Row(
                          children: [
                            Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                image: DecorationImage(
                                  image: AssetImage(Config.asset.orangeMoney),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text("ORANGE MONEY"),
                          ],
                        ),
                        value: "orange money",
                        groupValue: payementMethode,
                        onChanged: (value) {
                          setState(() {
                            payementMethode = value.toString();
                          });
                        },
                      ),
                      Divider(),
                      RadioListTile(
                        title: Row(
                          children: [
                            Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                image: DecorationImage(
                                  image: AssetImage(Config.asset.mtnMoney),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text("MTN MONEY"),
                          ],
                        ),
                        value: "mtn",
                        groupValue: payementMethode,
                        onChanged: (value) {
                          setState(() {
                            payementMethode = value.toString();
                          });
                        },
                      ),
                      Divider(),
                      RadioListTile(
                        title: Row(
                          children: [
                            Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                image: DecorationImage(
                                  image: AssetImage(Config.asset.moovMoney),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text("MOOV MONEY"),
                          ],
                        ),
                        value: "moov",
                        groupValue: payementMethode,
                        onChanged: (value) {
                          setState(() {
                            payementMethode = value.toString();
                          });
                        },
                      ),
                      Divider(),
                      // RadioListTile(
                      //   title: Row(
                      //     children: [
                      //       Container(
                      //         height: 40,
                      //         width: 40,
                      //         decoration: BoxDecoration(
                      //           borderRadius: BorderRadius.circular(20),
                      //           image: DecorationImage(
                      //             image: AssetImage(Config.asset.wave),
                      //             fit: BoxFit.cover,
                      //           ),
                      //         ),
                      //       ),
                      //       SizedBox(
                      //         width: 10,
                      //       ),
                      //       Text("WAVE"),
                      //     ],
                      //   ),
                      //   value: "wave",
                      //   groupValue: payementMethode,
                      //   onChanged: (value) {
                      //     setState(() {
                      //       payementMethode = value.toString();
                      //     });
                      //   },
                      // )
                    ],
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Destination",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    // controller: controller.phoneController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      filled: true,
                      hintText: "Entrer votre position",
                      hintStyle: TextStyle(
                        color: Config.colors.grayColor,
                        fontSize: 16,
                      ),
                      fillColor: Config.colors.backgroundTextField,
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Veuillez entrer votre numéro de téléphone';
                      }
                      // Vous pouvez ajouter d'autres validations ici si nécessaire
                      return null;
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
