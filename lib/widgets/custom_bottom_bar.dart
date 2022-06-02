import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/option_provider.dart';

class CustomBottomBar extends StatelessWidget {
  const CustomBottomBar({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    final uiProvider = Provider.of<OptionSelected>(context);
    final currentIndex = uiProvider.selectedMenuOption;

    return BottomNavigationBar(
      onTap: (value) => uiProvider.selectedMenuOption = value,
      currentIndex: currentIndex,
      elevation: 0,
      showSelectedLabels: true,
      showUnselectedLabels: false,
      items: const [
        BottomNavigationBarItem(icon:Icon(Icons.map_rounded), label: 'Map'),
        BottomNavigationBarItem(icon: Icon(Icons.link), label: 'Links'),
      ],
    );
  }
}