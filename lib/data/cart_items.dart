


import 'package:flutter_bloc_tutorial/features/product/models/home_product_data_model.dart';

class CartRepo {
  Map<String, ProductDataModel> _cartItems = {}; 

  Map<String, ProductDataModel> get cartItems => _cartItems;

  void addItemToCart(ProductDataModel product) {
    _cartItems[product.id] = product;
  }

  void removeItemFromCart(ProductDataModel product) {
    if (product.quantityInCart == 0) _cartItems.remove(product.id);
    else _cartItems[product.id] = product;
  }

}