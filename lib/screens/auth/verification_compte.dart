import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:malo_ivoire_app/config/config.dart';
import 'package:malo_ivoire_app/config/function.dart';
import 'package:malo_ivoire_app/controllers/register_controller.dart';
import 'package:malo_ivoire_app/widgets/button.dart';
import 'package:malo_ivoire_app/widgets/textField.dart';

class VerificationCompte extends StatelessWidget {
  VerificationCompte({super.key});
  final registerController = Get.put(RegisterController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: height(context),
          child: Padding(
            padding: const EdgeInsets.only(top: 35.0),
            child: GetBuilder<RegisterController>(builder: (controller) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
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
                          "Vérification d'identité",
                          style: TextStyle(
                            fontSize: 36,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Text(
                          "Votre reponse vous permettra de récupérer votre mot de passe au cas ou vous la perdez",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Text(
                          "C'est quoi votre couleur préféré?",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        CtextField(
                          controller: controller.favorieColorController,
                          hint: 'Votre couleur',
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
                    title: "Envoyer",
                    onPressed: () {
                      controller.checkRegisterColeurUser();
                    },
                  )
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
}
