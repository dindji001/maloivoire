import 'dart:convert';

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:malo_ivoire_app/network/network_handler.dart';

import 'package:shared_preferences/shared_preferences.dart';

class RizNomalInfoController extends GetxController {
  String token = "";
  // List<CategoriePriceModel> categorieList = [];
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  @override
  Future<void> getPriceGategoryFunction() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    token = pref.getString("token")!;
    var headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token',
    };

    try {
      var url = Uri.parse(
          ApiEndPoints.baseUrl + ApiEndPoints.authEndPoints.getGategory);

      http.Response response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        print(json);
        var sub_category_price_5kg = json[0]['sub_category_price'];
        var sub_category_qte_5kg = json[0]['sub_category_qte'];
        var sub_category_price_25kg = json[2]['sub_category_price'];
        var sub_category_qte_25kg = json[2]['sub_category_qte'];
        var sub_category_price_50kg = json[3]['sub_category_price'];
        var sub_category_qte_50kg = json[3]['sub_category_qte'];
        var sub_category_price_5x5kg = json[1]['sub_category_price'];
        var sub_category_qte_5x5kg = json[1]['sub_category_qte'];

        SharedPreferences prefs = await _prefs;
        prefs.setString('sub_category_price_5kg', sub_category_price_5kg);
        prefs.setString('sub_category_qte_5kg', sub_category_qte_5kg);
        prefs.setString('sub_category_price_25kg', sub_category_price_25kg);
        prefs.setString('sub_category_qte_25kg', sub_category_qte_25kg);
        prefs.setString('sub_category_price_50kg', sub_category_price_50kg);
        prefs.setString('sub_category_qte_50kg', sub_category_qte_50kg);
        prefs.setString('sub_category_price_5x5kg', sub_category_price_5x5kg);
        prefs.setString('sub_category_qte_5x5kg', sub_category_qte_5x5kg);
      } else {
        throw jsonDecode(response.body)["Message"] ?? "Unknown Error Occured";
      }
    } catch (error) {
      Get.snackbar(
        backgroundColor: Color(0xffff5c5c),
        snackPosition: SnackPosition.TOP,
        colorText: Colors.white10,
        'Erreur',
        '$error',
        forwardAnimationCurve: Curves.elasticInOut,
        reverseAnimationCurve: Curves.easeOut,
      );
    }
  }
}
