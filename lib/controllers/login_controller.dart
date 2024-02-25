import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:http/http.dart' as http;
import 'package:malo_ivoire_app/config/config.dart';
import 'package:malo_ivoire_app/network/network_handler.dart';
import 'package:malo_ivoire_app/screens/homes/home_page.dart';
import 'package:malo_ivoire_app/widgets/loader.dart';

import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController {
  late TextEditingController phoneController;
  late TextEditingController passwordController;
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  @override
  void onInit() {
    phoneController = TextEditingController();
    passwordController = TextEditingController();
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
    phoneController.dispose();
    passwordController.dispose();
  }

  checkLogin() {
    if (phoneController.text.isEmpty) {
      Get.snackbar(
        backgroundColor: Color(0xffff5c5c),
        snackPosition: SnackPosition.TOP,
        colorText: Config.colors.whithColor,
        'Champs vide',
        'Le champs telephone est obligatoire',
        forwardAnimationCurve: Curves.elasticInOut,
        reverseAnimationCurve: Curves.easeOut,
      );
    } else if (passwordController.text.isEmpty) {
      Get.snackbar(
        backgroundColor: Color(0xffff5c5c),
        snackPosition: SnackPosition.TOP,
        colorText: Config.colors.whithColor,
        'Champs vide',
        'Le champs mot de passe est obligatoire',
        forwardAnimationCurve: Curves.elasticInOut,
        reverseAnimationCurve: Curves.easeOut,
      );
    } else {
      Get.showOverlay(
          asyncFunction: () => loginWithPhone(), loadingWidget: Loader());
    }
  }

  Future<void> loginWithPhone() async {
    var headers = {
      'Content-Type': 'application/json; charset=UTF-8',
    };
    try {
      var url = Uri.parse(
          ApiEndPoints.baseUrl + ApiEndPoints.authEndPoints.loginUser);
      Map body = {
        'user_phone': phoneController.text,
        'user_password': passwordController.text
      };

      http.Response response =
          await http.post(url, body: jsonEncode(body), headers: headers);

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        inspect(json);

        if (json['message'] == "login effectué avec success") {
          // inspect(json);
          var token = json['user_token'];
          var user_firstname = json['user_firstname'];
          var user_lastname = json['user_lastname'];
          var user_id = json['user_id'];
          var user_phone = json['user_phone'];

          print(
            json,
          );

          phoneController.clear();
          passwordController.clear();
          Get.snackbar(
            backgroundColor: Color(0xff3cb043),
            snackPosition: SnackPosition.TOP,
            colorText: Config.colors.whithColor,
            'Connecté',
            json['message'],
            forwardAnimationCurve: Curves.elasticInOut,
            reverseAnimationCurve: Curves.easeOut,
          );
          pageRoute(
            token,
            user_firstname,
            user_lastname,
            user_phone,
          );
          CircularProgressIndicator(
            color: Config.colors.primaryColor,
          );
        } else if (json['message'] != "login effectué avec success") {
          throw jsonDecode(response.body)['message'];
        }
      } else {
        throw jsonDecode(response.body)["Message"] ?? "Unknown Error Occured";
      }
    } catch (error) {
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
    String token,
    String user_firstname,
    String user_lastname,
    // String user_id,
    String user_phone,
    // String user_phone,
  ) async {
    SharedPreferences prefs = await _prefs;
    prefs.setString('token', token);
    // prefs.setString('user_id', user_id);
    prefs.setString('user_firstname', user_firstname);
    prefs.setString('user_lastname', user_lastname);
    prefs.setString('user_phone', user_phone);
    Get.off(HomePage());
  }
}
