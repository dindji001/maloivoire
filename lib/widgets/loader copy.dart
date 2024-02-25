import 'package:flutter/material.dart';
import 'package:malo_ivoire_app/config/config.dart';

class Loader extends StatelessWidget {
  const Loader({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        color: Config.colors.secondaryColor,
      ),
    );
  }
}
