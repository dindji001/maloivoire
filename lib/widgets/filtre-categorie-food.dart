import 'package:flutter/material.dart';
import 'package:malo_ivoire_app/config/config.dart';

class FiltreCetegorieFood extends StatefulWidget {
  const FiltreCetegorieFood({super.key});

  @override
  State<FiltreCetegorieFood> createState() => _FiltreCetegorieFoodState();
}

class _FiltreCetegorieFoodState extends State<FiltreCetegorieFood> {
  var _selectedTag = 1;
  List<bool> _isExpanded = [false, true, false]; // Ajout du tableau de booléens

  void changeTag(int index) {
    setState(() {
      _selectedTag = index;
      updateExpandedState(index);
    });
  }

  // Mettre à jour les valeurs isExpanded en fonction de l'index
  void updateExpandedState(int index) {
    for (int i = 0; i < _isExpanded.length; i++) {
      _isExpanded[i] = (i == index);
    }
  }

  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomTabViewGategorie(
          index: _selectedTag,
          changeTab: changeTag,
          isExpanded:
              _isExpanded, // Passer _isExpanded à CustomTabViewGategorie
        ),
      ],
    );
  }
}

class CustomTabViewGategorie extends StatefulWidget {
  final Function(int) changeTab;
  final int index;
  final List<bool> isExpanded; // Ajout de la liste isExpanded
  const CustomTabViewGategorie(
      {super.key,
      required this.changeTab,
      required this.index,
      required this.isExpanded});

  @override
  State<CustomTabViewGategorie> createState() => _CustomTabViewGategorieState();
}

class _CustomTabViewGategorieState extends State<CustomTabViewGategorie> {
  final List<String> _tags = [
    "Riz Diététique ",
    "Riz normal",
    "Autre variété",
  ];

  Widget _buildTags(int index) {
    return GestureDetector(
      onTap: () {
        widget.changeTab(index);
      },
      child: Column(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 500),
            child: Container(
              alignment: Alignment.center,
              height: 50,
              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(10)),
                color:
                    widget.index == index ? Config.colors.secondaryColor : null,
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  _tags[index],
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: widget.index == index
                          ? Config.colors.whithColor
                          : null),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget build(BuildContext context) {
    return Row(
      children: _tags
          .asMap()
          .entries
          .map(
            (MapEntry map) => _buildTags(map.key),
          )
          .toList(),
    );
  }
}
