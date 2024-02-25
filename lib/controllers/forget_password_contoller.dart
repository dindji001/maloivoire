import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:malo_ivoire_app/config/config.dart';
import 'package:malo_ivoire_app/network/network_handler.dart';
import 'package:malo_ivoire_app/screens/auth/forgetPassword/renitialisation_passeword.dart';
import 'package:malo_ivoire_app/screens/auth/login-page.dart';
import 'package:malo_ivoire_app/widgets/loader.dart';

import 'package:shared_preferences/shared_preferences.dart';

class ForgetPasswordController extends GetxController {
  late TextEditingController phoneController;
  late TextEditingController favorieColorController;
  late TextEditingController newUserPasswordController;
  late TextEditingController confirmeNewUserPasswordController;
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  @override
  void onInit() {
    phoneController = TextEditingController();
    favorieColorController = TextEditingController();
    newUserPasswordController = TextEditingController();
    confirmeNewUserPasswordController = TextEditingController();
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
    newUserPasswordController.dispose();
    phoneController.dispose();
    favorieColorController.dispose();
    confirmeNewUserPasswordController.dispose();
  }

  checkForgetPassword() {
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
    } else if (favorieColorController.text.isEmpty) {
      Get.snackbar(
        backgroundColor: Color(0xffff5c5c),
        snackPosition: SnackPosition.TOP,
        colorText: Config.colors.whithColor,
        'Champs vide',
        'Le champs couleur obligatoire',
        forwardAnimationCurve: Curves.elasticInOut,
        reverseAnimationCurve: Curves.easeOut,
      );
    } else {
      Get.to(RenitialisationPassword());
    }
  }

  checkNewpassWordEmpty() {
    if (newUserPasswordController.text.isEmpty) {
      Get.snackbar(
        backgroundColor: Color(0xffff5c5c),
        snackPosition: SnackPosition.TOP,
        colorText: Config.colors.whithColor,
        'Champs vide',
        'Le champs Mot de pass est obligatoire',
        forwardAnimationCurve: Curves.elasticInOut,
        reverseAnimationCurve: Curves.easeOut,
      );
    } else {
      Get.showOverlay(
          asyncFunction: () => forgetPasswordWithColor(),
          loadingWidget: Loader());
    }
  }

  Future<void> forgetPasswordWithColor() async {
    var headers = {
      'Content-Type': 'application/json; charset=UTF-8',
    };

    try {
      var url = Uri.parse(
          ApiEndPoints.baseUrl + ApiEndPoints.authEndPoints.forgetPassword);
      Map body = {
        'user_phone': phoneController.text,
        'user_question': favorieColorController.text,
        'user_newpassword': newUserPasswordController.text
      };

      http.Response response =
          await http.post(url, body: jsonEncode(body), headers: headers);
      print('bonjour');
      // print(jsonDecode(response.body));
      print('bonsoir');
      inspect(response.body);
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);

        if (json['message'] == "reinitalisé avec success") {
          // inspect(json['message']);
          phoneController.clear();
          favorieColorController.clear();
          confirmeNewUserPasswordController.clear();
          newUserPasswordController.clear();
          Get.snackbar(
            backgroundColor: Color(0xff3cb043),
            snackPosition: SnackPosition.TOP,
            colorText: Config.colors.whithColor,
            'Connecté',
            json['message'],
            forwardAnimationCurve: Curves.elasticInOut,
            reverseAnimationCurve: Curves.easeOut,
          );
          CircularProgressIndicator(
            color: Config.colors.primaryColor,
          );
          pageRoute();
        } else if (json['message'] != "reinitalisé avec success") {
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

  void pageRoute() async {
    Get.off(LoginPage());
  }
}
