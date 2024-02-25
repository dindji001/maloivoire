import 'package:flutter/material.dart';
import 'package:malo_ivoire_app/config/config.dart';
import 'package:malo_ivoire_app/config/function.dart';
import 'package:malo_ivoire_app/screens/commande-page.dart';
import 'package:malo_ivoire_app/screens/homes/body_home.dart';
import 'package:malo_ivoire_app/screens/user-page.dart';

class RootApp extends StatefulWidget {
  const RootApp({super.key});

  @override
  State<RootApp> createState() => _RootAppState();
}

class _RootAppState extends State<RootApp> {
  int pageIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: getFooter(),
      body: getBody(),
    );
  }

  Widget getBody() {
    return IndexedStack(
      index: pageIndex,
      children: [
        BodyHomePage(),
        ListCommandePage(),
        ProfilUser(),
      ],
    );
  }

  Widget getFooter() {
    List items = [
      Icons.home_filled,
      Icons.format_list_numbered,
      Icons.person_rounded,
    ];
    return Container(
      width: width(context),
      height: 80,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ), //BorderRadius.Only
        color: Config.colors.textColor,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(
          items.length,
          (index) {
            return InkWell(
              onTap: () {
                setState(() {
                  pageIndex = index;
                });
              },
              child: AnimatedContainer(
                duration: Duration(milliseconds: 500),
                child: Container(
                  height: 45,
                  width: 45,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: pageIndex == index
                        ? Config.colors.primaryColor
                        : Config.colors.textColor,
                  ),
                  child: Icon(
                    items[index],
                    size: 20,
                    color: Config.colors.whithColor,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
