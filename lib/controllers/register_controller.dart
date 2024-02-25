import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:malo_ivoire_app/config/config.dart';
import 'package:malo_ivoire_app/network/network_handler.dart';
import 'package:malo_ivoire_app/screens/auth/login-page.dart';
import 'package:malo_ivoire_app/screens/auth/verification_compte.dart';
import 'package:malo_ivoire_app/widgets/loader.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class RegisterController extends GetxController {
  late TextEditingController phoneController;
  late TextEditingController passwordController;
  late TextEditingController nameController;
  late TextEditingController firstNameController;
  late TextEditingController favorieColorController;

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  @override
  void onInit() {
    phoneController = TextEditingController();
    passwordController = TextEditingController();
    nameController = TextEditingController();
    firstNameController = TextEditingController();
    favorieColorController = TextEditingController();
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
    phoneController.dispose();
    passwordController.dispose();
    nameController.dispose();
    firstNameController.dispose();
    favorieColorController.dispose();
  }

  checkRegisterUserInfo() {
    if (nameController.text.isEmpty) {
      Get.snackbar(
        backgroundColor: Color(0xffff5c5c),
        snackPosition: SnackPosition.TOP,
        colorText: Config.colors.whithColor,
        'Champs vide',
        'Le champs nom est obligatoire',
        forwardAnimationCurve: Curves.elasticInOut,
        reverseAnimationCurve: Curves.easeOut,
      );
    } else if (firstNameController.text.isEmpty) {
      Get.snackbar(
        backgroundColor: Color(0xffff5c5c),
        snackPosition: SnackPosition.TOP,
        colorText: Config.colors.whithColor,
        'Champs vide',
        'Le champs prénoms est obligatoire',
        forwardAnimationCurve: Curves.elasticInOut,
        reverseAnimationCurve: Curves.easeOut,
      );
    } else if (phoneController.text.isEmpty) {
      Get.snackbar(
        backgroundColor: Color(0xffff5c5c),
        snackPosition: SnackPosition.TOP,
        colorText: Config.colors.whithColor,
        'Champs vide',
        'Le champs téléphone est obligatoire',
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
      Get.snackbar(
        backgroundColor: Color(0xff3cb043),
        snackPosition: SnackPosition.TOP,
        colorText: Config.colors.whithColor,
        'Enregistré',
        'Information bien enregistrer',
        forwardAnimationCurve: Curves.elasticInOut,
        reverseAnimationCurve: Curves.easeOut,
      );
      CircularProgressIndicator(
        color: Config.colors.primaryColor,
      );
      Get.off(VerificationCompte());
    }
  }

  // route(context, VerificationCompte());
  checkRegisterColeurUser() {
    if (favorieColorController.text.isEmpty) {
      Get.snackbar(
        backgroundColor: Color(0xffff5c5c),
        snackPosition: SnackPosition.TOP,
        colorText: Config.colors.whithColor,
        'Champs vide',
        'Veuillez definir votre couleur préféré',
        forwardAnimationCurve: Curves.elasticInOut,
        reverseAnimationCurve: Curves.easeOut,
      );
    } else {
      Get.showOverlay(
        asyncFunction: () => registerUserWithColor(),
        loadingWidget: Loader(),
      );
    }
  }

  Future<void> registerUserWithColor() async {
    var headers = {
      'Content-Type': 'application/json; charset=UTF-8',
    };

    try {
      var url = Uri.parse(
          ApiEndPoints.baseUrl + ApiEndPoints.authEndPoints.registerUser);
      Map body = {
        'user_phone': phoneController.text,
        'user_password': passwordController.text,
        'user_firstname': nameController.text,
        'user_lastname': firstNameController.text,
        'user_question': favorieColorController.text,
        'user_role': '2'
      };

      http.Response response =
          await http.post(url, body: jsonEncode(body), headers: headers);
      inspect(response.body);
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        var message = json['message'];
        print(message);
        if (message == "enregistrement ok ") {
          print('ok');
          phoneController.clear();
          passwordController.clear();
          firstNameController.clear();
          nameController.clear();
          favorieColorController.clear();

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
          Get.off(LoginPage());
        } else {
          phoneController.clear();
          passwordController.clear();
          firstNameController.clear();
          nameController.clear();
          favorieColorController.clear();
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
}
