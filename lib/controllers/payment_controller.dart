import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:malo_ivoire_app/config/config.dart';
import 'package:malo_ivoire_app/network/network_handler.dart';
import 'package:malo_ivoire_app/screens/payement/validate_payement_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PaymentController extends GetxController {
  late TextEditingController phoneController;
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  @override
  void onInit() {
    phoneController = TextEditingController();
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
    phoneController.dispose();
  }

  Future<void> loginWithPayement(prix, name, firname, numcommande) async {
    var headers = {
      'X-SYCA-MERCHANDID': 'C_6489B1733F1DD',
      'X-SYCA-APIKEY': 'pk_syca_ecdacba8e05589a724a87b2da65d08322625eb99',
      'X-SYCA-REQUEST-DATA-FORMAT': 'JSON',
      'X-SYCA-RESPONSE-DATA-FORMAT': 'JSON',
    };

    try {
      var url = Uri.parse(
          ApiEndPoints.baseUrl2 + ApiEndPoints.authEndPoints.loginPayment);
      Map body = {
        "montant": prix,
        "currency": "XOF",
      };

      http.Response response =
          await http.post(url, body: jsonEncode(body), headers: headers);

      print(jsonDecode(response.body));

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        if (json['desc'] == "SUCCESS") {
          var token = json['token'];
          inspect(json);
          var url2 = Uri.parse(ApiEndPoints.baseUrl2 +
              ApiEndPoints.authEndPoints.checkoutpayPayment);
          Map body2 = {
            "marchandid": "C_6489B1733F1DD",
            "token": token,
            "telephone": phoneController.text,
            "name": name,
            "pname": firname,
            "montant": prix,
            "currency": "XOF",
            "numcommande": numcommande
          };

          http.Response response2 =
              await http.post(url2, body: jsonEncode(body2));
          if (response2.statusCode == 200) {
            final json2 = jsonDecode(response2.body);

            if ((json2['code']) == -18) {
              Get.snackbar(
                backgroundColor: Color(0xffff5c5c),
                snackPosition: SnackPosition.TOP,
                colorText: Config.colors.whithColor,
                'Numero Incorrect',
                json2['message'],
                forwardAnimationCurve: Curves.elasticInOut,
                reverseAnimationCurve: Curves.easeOut,
              );
            } else {
              var operateur = json2['operator'];
              CircularProgressIndicator(
                color: Config.colors.primaryColor,
              );
              pageRoute(operateur);
            }
          } else {
            throw jsonDecode(response2.body)["Message"] ??
                "Unknown Error Occured";
          }
        } else if (json['desc'] != "SUCCESS") {
          throw jsonDecode(response.body)['message'];
        }

        // print(json['message']);
        // if (json['message'] == "login effectué avec success") {
        //   var token = json['user_token'];
        //   var user_firstname = json['user_firstname'];
        //   var user_lastname = json['user_lastname'];
        //   print(token);
        //   // phoneController.clear();
        //   // passwordController.clear();
        //   Get.snackbar(
        //     backgroundColor: Color(0xff3cb043),
        //     snackPosition: SnackPosition.TOP,
        //     colorText: Config.colors.whithColor,
        //     'Connecté',
        //     json['message'],
        //     forwardAnimationCurve: Curves.elasticInOut,
        //     reverseAnimationCurve: Curves.easeOut,
        //   );
        //   pageRoute(token, user_firstname, user_lastname);
        //   CircularProgressIndicator(
        //     color: Config.colors.primaryColor,
        //   );
        // } else if (json['message'] != "login effectué avec success") {
        //   throw jsonDecode(response.body)['message'];
        // }
      } else {
        throw jsonDecode(response.body)["Message"] ?? "Unknown Error Occured";
      }
    } catch (error) {
      print("saliut tous le monde");
      Get.snackbar(
        backgroundColor: Color(0xffff5c5c),
        snackPosition: SnackPosition.TOP,
        colorText: Config.colors.whithColor,
        'Erreur',
        '$error',
        forwardAnimationCurve: Curves.elasticInOut,
        reverseAnimationCurve: Curves.easeOut,
      );
    }
  }

  void pageRoute(
    String operateur,
  ) async {
    SharedPreferences prefs = await _prefs;
    prefs.setString('operateur', operateur);
    Get.off(const ValidatePayementPage());
  }
}
