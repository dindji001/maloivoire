import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:malo_ivoire_app/config/config.dart';
import 'package:malo_ivoire_app/controllers/payment_controller.dart';
import 'package:malo_ivoire_app/widgets/button.dart';

import 'package:shared_preferences/shared_preferences.dart';

class PayementButtonSheet extends StatefulWidget {
  final int prixTotal;
  final int deliveryPrice;
  final int quantity_order;
  final int order_price;
  PayementButtonSheet({
    super.key,
    required this.prixTotal,
    required this.deliveryPrice,
    required this.quantity_order,
    required this.order_price,
  });

  @override
  State<PayementButtonSheet> createState() => _PayementButtonSheetState();
}

class _PayementButtonSheetState extends State<PayementButtonSheet> {
  String user_firstname = "";
  String user_lastname = "";
  String initials = "";
  String randomWord = "";

  final PaymentController paymentController = Get.put(PaymentController());
  // final NewOrderController newOrderController = Get.put(NewOrderController());

  final _formKey = GlobalKey<FormState>();

  late String _phoneNumber;

  late String _password;

  @override
  void initState() {
    super.initState();
    getNameFirname();
    setState(() {
      randomWord = generateRandomWord();
    });
    print('Mot généré : $randomWord');
  }

  String generateRandomWord() {
    Random random = Random();
    String word = '';

    // Générer 4 chiffres
    for (int i = 0; i < 6; i++) {
      int digit = random.nextInt(10); // Génère un chiffre entre 0 et 9
      word += digit.toString();
    }

    // Générer 5 lettres en majuscules et minuscules
    for (int i = 0; i < 6; i++) {
      bool isUppercase = random
          .nextBool(); // Détermine si la lettre est en majuscule ou minuscule
      int letterCode = random.nextInt(26) +
          (isUppercase
              ? 65
              : 97); // Génère un code ASCII pour une lettre majuscule ou minuscule
      String letter = String.fromCharCode(letterCode);
      word += letter;
    }

    return word;
  }

  void getNameFirname() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    setState(() {
      user_firstname = pref.getString("user_firstname")!;
      user_lastname = pref.getString("user_lastname")!;
    });
  }

  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        decoration: BoxDecoration(
            color: Config.colors.whithColor,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
        child: GetBuilder<PaymentController>(
          builder: (controller) {
            return Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset(
                        Config.asset.logo,
                        width: 45,
                        height: 45,
                      ),
                      IconButton(
                        onPressed: () {
                          Get.back();
                        },
                        icon: Icon(
                          Icons.clear,
                          size: 30,
                        ),
                      )
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Entrer votre numéro de téléphone",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      IntlPhoneField(
                        controller: controller.phoneController,
                        onSaved: (value) {
                          _phoneNumber = value! as String;
                        },
                        initialCountryCode: 'CI',
                        decoration: InputDecoration(
                          filled: true,
                          hintText: 'Numéro de téléphone',
                          hintStyle: TextStyle(
                            color: Config.colors.textColor,
                            fontSize: 16,
                          ),
                          fillColor: Config.colors.backgroundTextField,
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GetBuilder<PaymentController>(
                      builder: (controller) {
                        return CButton(
                          color: Config.colors.secondaryColor,
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              var prix = widget.prixTotal;
                              var orderPrice = widget.order_price;

                              var prixLivraison = widget.deliveryPrice;
                              var quantity = widget.quantity_order;

                              paymentController.loginWithPayement(
                                prix,
                                user_firstname,
                                user_lastname,
                                randomWord,
                              );
                              // newOrderController.newOrder(
                              //   prix,
                              //   prixLivraison,
                              //   quantity,
                              //   orderPrice,
                              // );
                            } else {
                              // Show error message or perform any desired action
                              Get.snackbar(
                                backgroundColor: Config.colors.roseColor,
                                snackPosition: SnackPosition.TOP,
                                colorText: Config.colors.whithColor,
                                'Numero de telephone',
                                'non prise ne compte',
                                forwardAnimationCurve: Curves.elasticInOut,
                                reverseAnimationCurve: Curves.easeOut,
                              );
                            }
                          },
                          title: 'payer',
                        );
                      },
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
// GetBuilder<LoginController>(builder: (controller)){}