import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:malo_ivoire_app/config/config.dart';
import 'package:malo_ivoire_app/config/function.dart';
import 'package:malo_ivoire_app/controllers/register_controller.dart';
import 'package:malo_ivoire_app/screens/auth/login-page.dart';
import 'package:malo_ivoire_app/widgets/button.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final registerController = Get.put(RegisterController());
  bool _isPasswordFieldFocused = false;
  bool _isPasswordVisible = false;
  FocusNode _passwordFocusNode = FocusNode();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _passwordFocusNode.addListener(() {
      setState(() {
        _isPasswordFieldFocused = _passwordFocusNode.hasFocus;
      });
    });
  }

  void _togglePasswordVisibility() {
    setState(() {
      _isPasswordVisible = !_isPasswordVisible;
    });
  }

  @override
  void dispose() {
    _passwordFocusNode.dispose();

    super.dispose();
  }

  void _showErrorSnackbar(String message) {
    final snackBar = SnackBar(
      content: Text(message),
      duration: Duration(seconds: 3),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          child: Padding(
            padding: const EdgeInsets.only(top: 15.0),
            child: GetBuilder<RegisterController>(builder: (controller) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    height: height(context) * 0.3,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(Config.asset.logo),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 20, left: 20),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          Text(
                            "Inscription",
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: TextFormField(
                                  controller: controller.nameController,
                                  decoration: InputDecoration(
                                    filled: true,
                                    hintText: "Nom",
                                    hintStyle: TextStyle(
                                      color: Config.colors.grayColor,
                                      fontSize: 16,
                                    ),
                                    fillColor:
                                        Config.colors.backgroundTextField,
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Veuillez entrer votre nom';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              SizedBox(width: 5),
                              Expanded(
                                flex: 1,
                                child: TextFormField(
                                  controller: controller.firstNameController,
                                  decoration: InputDecoration(
                                    filled: true,
                                    hintText: "Prénoms",
                                    hintStyle: TextStyle(
                                      color: Config.colors.grayColor,
                                      fontSize: 16,
                                    ),
                                    fillColor:
                                        Config.colors.backgroundTextField,
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Veuillez entrer votre prénom';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            controller: controller.phoneController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              filled: true,
                              hintText: "Numero de telephone",
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
                          SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            controller: controller.passwordController,
                            focusNode: _passwordFocusNode,
                            obscureText: !_isPasswordVisible,
                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                icon: Icon(
                                  color: _isPasswordFieldFocused
                                      ? Colors.blue
                                      : Config.colors.primaryColor,
                                  _isPasswordVisible
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                ),
                                onPressed: _togglePasswordVisibility,
                              ),
                              filled: true,
                              hintText: "Mot de passe",
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
                              if (value!.isEmpty) {
                                return 'Veuillez entrer votre mot de passe';
                              } else if (value.length < 6) {
                                return 'Le mot de passe doit contenir au moins 6 caractères';
                              } else if (!containsUppercaseLetter(value)) {
                                return 'Le mot de passe doit contenir au moins une lettre majuscule';
                              } else if (!containsNumber(value)) {
                                return 'Le mot de passe doit contenir au moins un chiffre';
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          CButton(
                            title: "INSCRIPTION",
                            onPressed: () {
                              // Avant de naviguer vers la page suivante, vous pouvez valider le formulaire.
                              if (_formKey.currentState!.validate()) {
                                // Si le formulaire est valide, enregistrez les données et naviguez vers la page suivante.
                                _formKey.currentState!.save();
                                controller.checkRegisterUserInfo();
                              } else {
                                // Afficher un SnackBar en cas d'erreur de validation.
                                _showErrorSnackbar(
                                    'Veuillez corriger les erreurs dans le formulaire.');
                              }
                            },
                          ),
                          SizedBox(
                            height: 30,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Vous avez déjà un compte?",
                        style: TextStyle(
                          color: Config.colors.textColor,
                          fontSize: 12,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          route(context, LoginPage());
                        },
                        child: Text(
                          "Connectez-vous",
                          style: TextStyle(
                              color: Config.colors.secondaryColor,
                              fontSize: 12,
                              fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  )
                ],
              );
            }),
          ),
        ),
      ),
    );
  }

  bool containsUppercaseLetter(String value) {
    return value.contains(RegExp(r'[A-Z]'));
  }

  bool containsNumber(String value) {
    return value.contains(RegExp(r'[0-9]'));
  }
}
