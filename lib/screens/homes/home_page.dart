import 'package:flutter/material.dart';
import 'package:malo_ivoire_app/config/config.dart';
import 'package:malo_ivoire_app/config/function.dart';
import 'package:malo_ivoire_app/screens/auth/login-page.dart';
import 'package:malo_ivoire_app/screens/homes/body_home.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String token = "";
  String user_firstname = "";
  String user_lastname = "";
  String user_phone = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCred();
  }

  void getCred() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    setState(() {
      token = pref.getString("token")!;
      user_firstname = pref.getString("user_firstname")!;
      user_lastname = pref.getString("user_lastname")!;
      user_phone = pref.getString("user_phone")!;
      print("Severin dindji wilfried");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Config.colors.textColor, // <-- SEE HERE
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Malo Ivoire',
              style: TextStyle(
                color: Config.colors.secondaryColor,
                fontSize: 12,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              "27 BP 24 Abidjan 27",
              style: TextStyle(
                color: Config.colors.grayColor,
                fontSize: 12,
              ),
            )
          ],
        ),
        leading: Padding(
          padding: const EdgeInsets.only(left: 15, top: 15),
          child: Row(
            children: [
              Builder(
                builder: (BuildContext context) {
                  return InkWell(
                    onTap: () {
                      Scaffold.of(context).openDrawer();
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 28,
                          height: 2,
                          color: Config.colors.whithColor,
                        ),
                        SizedBox(
                          height: 3.5,
                        ),
                        Container(
                          width: 23,
                          height: 2,
                          color: Config.colors.whithColor,
                        ),
                        SizedBox(
                          height: 3.5,
                        ),
                        Container(
                          width: 18,
                          height: 2,
                          color: Config.colors.whithColor,
                        )
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
        backgroundColor: Config.colors.secondaryColor,
        elevation: 0,
        actions: [
          Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              image: DecorationImage(
                image: AssetImage(Config.asset.profil),
              ),
            ),
          )
        ],
      ),
      drawer: Drawer(
        child: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            child: Column(
              children: [
                DrawerHeader(
                  child: Column(
                    children: [
                      Container(
                        height: 80,
                        width: 80,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          image: DecorationImage(
                            image: AssetImage(Config.asset.profil),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  children: [
                    Text(
                      '${user_firstname + " " + user_lastname}',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      '${user_phone} ',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
                Divider(),
                SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 20, left: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Méthodes de payement",
                      ),
                      Icon(Icons.attach_money)
                    ],
                  ),
                ),
                Divider(
                  thickness: 10,
                  height: 50,
                  color: Config.colors.backgroundTextField,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: Config.colors.backgroundTextField,
                          ),
                          child: Icon(
                            Icons.security,
                            size: 30,
                            color: Config.colors.secondaryColor,
                          ),
                        ),
                        Text(
                          "Sécurité",
                          style: TextStyle(
                              fontSize: 12, color: Config.colors.textColor),
                        )
                      ],
                    ),
                    Column(
                      children: [
                        Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: Config.colors.backgroundTextField,
                          ),
                          child: Icon(
                            Icons.headset_mic,
                            size: 30,
                            color: Config.colors.secondaryColor,
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          child: Text(
                            textAlign: TextAlign.center,
                            "Service d’assistance",
                            style: TextStyle(
                                fontSize: 12, color: Config.colors.textColor),
                          ),
                        )
                      ],
                    ),
                    Column(
                      children: [
                        Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: Config.colors.backgroundTextField,
                          ),
                          child: Icon(
                            Icons.settings,
                            size: 30,
                            color: Config.colors.secondaryColor,
                          ),
                        ),
                        Text(
                          "Paramètres",
                          style: TextStyle(
                              fontSize: 12, color: Config.colors.textColor),
                        )
                      ],
                    )
                  ],
                ),
                Divider(
                  thickness: 10,
                  height: 50,
                  color: Config.colors.backgroundTextField,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 20, left: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Mes adresses",
                        style: TextStyle(color: Config.colors.textColor),
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 20,
                      )
                    ],
                  ),
                ),
                Divider(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 20, left: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Historique des commandes ",
                          style: TextStyle(color: Config.colors.textColor)),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 20,
                      )
                    ],
                  ),
                ),
                Divider(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 20, left: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Aides et supports",
                          style: TextStyle(color: Config.colors.textColor)),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 20,
                      )
                    ],
                  ),
                ),
                Divider(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 20, left: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Informations & details",
                          style: TextStyle(color: Config.colors.textColor)),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 20,
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextButton(
                  onPressed: () async {
                    SharedPreferences pref =
                        await SharedPreferences.getInstance();
                    await pref.remove('token');

                    route(context, LoginPage(), close: true);
                  },
                  child: Text(
                    "Deconnexion",
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: BodyHomePage(),
      ),
    );
  }
}
