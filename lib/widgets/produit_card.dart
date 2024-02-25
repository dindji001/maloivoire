import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final String productName;
  final String productPrice;
  final String assetImagePath;

  ProductCard(
    this.productName,
    this.productPrice,
    this.assetImagePath,
  );

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            height:
                150.0, // Ajustez la hauteur du conteneur de l'image selon vos besoins
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(assetImagePath),
                fit: BoxFit
                    .cover, // Ajustez le comportement de l'image en fonction de vos besoins
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 16, bottom: 16, right: 10, left: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  productName,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  'Prix : $productPrice',
                  style: TextStyle(
                    color: Colors.green,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
