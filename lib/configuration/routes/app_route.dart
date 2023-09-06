import 'dart:js';

import 'package:flutter/material.dart';
import 'package:flutter_bloc_tutorial/features/admin/ui/admin.dart';
import 'package:flutter_bloc_tutorial/features/admin/ui/admin_home.dart';
import 'package:flutter_bloc_tutorial/features/cart/ui/cart.dart';
import 'package:flutter_bloc_tutorial/features/home/ui/home.dart';
import 'package:flutter_bloc_tutorial/features/login/ui/loginPage.dart';
import 'package:flutter_bloc_tutorial/features/product/ui/admin_add_new_product.dart';
import 'package:flutter_bloc_tutorial/features/product/ui/admin_products_list_screen.dart';
import 'package:flutter_bloc_tutorial/features/wishlist/ui/wishlist.dart';

class AppRouter {

  Route onGenerateRoute(RouteSettings routeSettings) {
    
    switch (routeSettings.name) {

      case '/' : return MaterialPageRoute(builder: (context) => Login());
      case '/adminHome' : return MaterialPageRoute(builder: (context) => AdminHome());
      case '/adminProducts' : return MaterialPageRoute(builder: (context) => AdminProductsListScreen());
      case '/userHome' : return MaterialPageRoute(builder: (context) => Home());
      case '/userCart' : return MaterialPageRoute(builder: (context) => Cart());
      case '/userWishList' : return MaterialPageRoute(builder: (context) => Wishlist());
      case '/adminAddNewProduct' : return MaterialPageRoute(builder: (context) => AddNewProduct());
      default: return MaterialPageRoute(builder: (context) => Login());
    }
  }
}