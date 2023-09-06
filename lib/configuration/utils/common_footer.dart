import 'package:flutter/material.dart';

class CommonFooterMenu {
  BuildContext context;
  CommonFooterMenu(this.context);

  BottomNavigationBar getFooterMenu(int selectedIndex) {
    return BottomNavigationBar(
        onTap: (index) {
          if (index != selectedIndex) {
            goScreens(index);
          }
        },
        currentIndex: selectedIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu_book_rounded),
            label: "Products",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.integration_instructions),
            label: "orders",
          ),

        ]
      );
  }
  
  void goScreens(int index) {

    switch(index) {
      case 0: Navigator.pushNamed(context, '/adminHome');
        break;
      case 1: Navigator.pushNamed(context, '/adminProducts');
        break;
      case 2: Navigator.pushNamed(context, '/adminHome');
        break;
    }
  }
}