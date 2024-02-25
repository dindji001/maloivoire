import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:malo_ivoire_app/config/config.dart';
import 'package:malo_ivoire_app/config/function.dart';
import 'package:malo_ivoire_app/controllers/login_controller.dart';
import 'package:malo_ivoire_app/screens/auth/forgetPassword/recuperation_passeword.dart';
import 'package:malo_ivoire_app/screens/auth/register-page.dart';
import 'package:malo_ivoire_app/screens/homes/body_home.dart';
import 'package:malo_ivoire_app/screens/homes/home_page.dart';
import 'package:malo_ivoire_app/widgets/button.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  LoginController loginController = Get.put(LoginController());
  bool _isPasswordVisible = false;
  bool _isPasswordFieldFocused = false;
  final _formKey = GlobalKey<FormState>();
  late String _phoneNumber;
  late String _password;
  FocusNode _passwordFocusNode = FocusNode();
  var isLogin = false.obs;
  bool hasSpecialCharacter = false;
  bool hasUppercaseLetter = false;
  bool hasMinLength = false;
  bool hasNumber = false; // Nouvelle condition

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
      duration: Duration(seconds: 3), // Durée d'affichage du SnackBar
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 25.0),
          child: Column(
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
                padding: const EdgeInsets.only(right: 5, left: 5),
                child: Form(
                  key: _formKey,
                  child: GetBuilder<LoginController>(builder: (controller) {
                    return Column(
                      children: [
                        Text(
                          "Connexion",
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        TextFormField(
                          controller: controller.phoneController,
                          onSaved: (value) {
                            _phoneNumber = value!;
                          },
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
                            if (value!.isEmpty) {
                              return 'Veuillez entrer votre numéro de téléphone';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          controller: controller.passwordController,
                          onSaved: (value) {
                            _password = value!;
                          },
                          obscureText: !_isPasswordVisible,
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                              icon: Icon(
                                _isPasswordVisible
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: _isPasswordFieldFocused
                                    ? Colors.blue
                                    : Config.colors.primaryColor,
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
                            } else {
                              hasSpecialCharacter =
                                  containsSpecialCharacter(value);
                              hasUppercaseLetter =
                                  containsUppercaseLetter(value);
                              hasMinLength = value.length >= 6;
                              hasNumber =
                                  containsNumber(value); // Nouvelle condition
                              if (!hasSpecialCharacter ||
                                  !hasUppercaseLetter ||
                                  !hasMinLength ||
                                  !hasNumber) {
                                // Ajouter la nouvelle condition ici
                                return 'Le mot de passe doit respecter les conditions suivantes:';
                              }
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Icon(
                              hasSpecialCharacter
                                  ? Icons.check_circle
                                  : Icons.cancel,
                              color: hasSpecialCharacter
                                  ? Colors.green
                                  : Colors.red,
                            ),
                            Text('Au moins un caractère spécial'),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(
                              hasUppercaseLetter
                                  ? Icons.check_circle
                                  : Icons.cancel,
                              color: hasUppercaseLetter
                                  ? Colors.green
                                  : Colors.red,
                            ),
                            Text('Au moins une lettre majuscule'),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(
                              hasMinLength ? Icons.check_circle : Icons.cancel,
                              color: hasMinLength ? Colors.green : Colors.red,
                            ),
                            Text('Au moins 6 caractères'),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(
                              hasNumber ? Icons.check_circle : Icons.cancel,
                              color: hasNumber ? Colors.green : Colors.red,
                            ),
                            Text('Au moins un chiffre'), // Nouvelle condition
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        CButton(
                          title: "CONNEXION",
                          onPressed: () {
                            // Avant de naviguer vers la page suivante, vous pouvez valider le formulaire.
                            if (_formKey.currentState!.validate()) {
                              // Si le formulaire est valide, enregistrez les données et naviguez vers la page suivante.
                              _formKey.currentState!.save();
                              controller.checkLogin();
                            } else {
                              // Afficher un SnackBar en cas d'erreur de validation.
                              _showErrorSnackbar(
                                  'Veuillez corriger les erreurs dans le formulaire.');
                            }
                          },
                        ),
                      ],
                    );
                  }),
                ),
              ),
              TextButton(
                onPressed: () {
                  route(context, RecuperationPasseword());
                },
                child: Text(
                  "Mot de passe oublié?",
                  style: TextStyle(
                      fontSize: 14, color: Config.colors.secondaryColor),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Vous n’avez pas de compte?",
                    style:
                        TextStyle(color: Config.colors.textColor, fontSize: 12),
                  ),
                  TextButton(
                    onPressed: () {
                      route(context, RegisterPage());
                    },
                    child: Text(
                      "Inscrivez-vous",
                      style: TextStyle(
                          color: Config.colors.secondaryColor,
                          fontSize: 12,
                          fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  bool containsSpecialCharacter(String value) {
    final specialCharacters = RegExp(r'[!@#\$%^&*(),.?":{}|<>]');
    return specialCharacters.hasMatch(value);
  }

  bool containsUppercaseLetter(String value) {
    return value.contains(RegExp(r'[A-Z]'));
  }

  bool containsNumber(String value) {
    return value.contains(RegExp(r'[0-9]'));
  }
}
