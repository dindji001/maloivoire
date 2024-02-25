import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:malo_ivoire_app/config/config.dart';
import 'package:malo_ivoire_app/config/function.dart';
import 'package:malo_ivoire_app/controllers/forget_password_contoller.dart';
import 'package:malo_ivoire_app/widgets/button.dart';
import 'package:malo_ivoire_app/widgets/textField.dart';

class RecuperationPasseword extends StatefulWidget {
  const RecuperationPasseword({super.key});

  @override
  State<RecuperationPasseword> createState() => _RecuperationPassewordState();
}

class _RecuperationPassewordState extends State<RecuperationPasseword> {
  final forgetPasswordController = Get.put(
    ForgetPasswordController(),
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(
          color: Config.colors.secondaryColor,
        ),
      ),
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
                    height: height(context) * 0.2,
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
                          height: 20,
                        ),
                        Text(
                          "Entrer votre numero de telephone et votre couleur préféré",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        CtextField(
                          controller: controller.phoneController,
                          textInputType: TextInputType.number,
                          hint: 'Numero de telephone',
                          validator: (value) {},
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        CtextField(
                          controller: controller.favorieColorController,
                          textInputType: TextInputType.text,
                          hint: 'Couleur',
                          validator: (value) {},
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  CButton(
                    title: "verification",
                    onPressed: () {
                      controller.checkForgetPassword();
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
