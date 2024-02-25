import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:malo_ivoire_app/config/config.dart';
import 'package:malo_ivoire_app/config/function.dart';
import 'package:malo_ivoire_app/controllers/forget_password_contoller.dart';
import 'package:malo_ivoire_app/widgets/button.dart';
import 'package:malo_ivoire_app/widgets/textField.dart';

class RenitialisationPassword extends StatefulWidget {
  const RenitialisationPassword({super.key});

  @override
  State<RenitialisationPassword> createState() =>
      _RenitialisationPasswordState();
}

class _RenitialisationPasswordState extends State<RenitialisationPassword> {
  final forgetPasswordController = Get.put(
    ForgetPasswordController(),
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: height(context),
          child: Padding(
            padding: const EdgeInsets.only(top: 35.0, bottom: 35),
            child: GetBuilder<ForgetPasswordController>(builder: (controller) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: height(context) * 0.25,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(Config.asset.logo),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 20, left: 20),
                    child: Column(
                      children: [
                        Text(
                          "Rénitialisation de mot de passe",
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        CtextField(
                          controller: controller.newUserPasswordController,
                          hint: 'Nouveau mot de passe',
                          validator: (value) {},
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        CtextField(
                          hint: 'Confirmé mot de passe',
                          validator: (value) {},
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  CButton(
                      title: "Rénitialisé",
                      onPressed: () {
                        controller.checkNewpassWordEmpty();
                      })
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
}
