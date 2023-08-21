part of 'cart_bloc.dart';

@immutable
abstract class CartState {
    final int cartCount;
  final double cartAmount;
  CartState(this.cartCount, this.cartAmount);
}

abstract class CartActionState extends CartState {  
  CartActionState(int cartCount, double cartAmount) : super(cartCount, cartAmount);
}

class CartInitial extends CartState {
  CartInitial(): super(0,0);
}

class CartSuccessState extends CartState {
  final List<ProductDataModel> cartItems;
  CartSuccessState(int cartCount, double cartAmount, {
    required this.cartItems,
  }) : super(cartCount, cartAmount);
}

class CartRemoveItemMessageActionState extends CartActionState {
  final ProductDataModel removedItem;
  CartRemoveItemMessageActionState(int cartCount, double cartAmount, this.removedItem) : super(cartCount, cartAmount);
}

class CartItemsCountState extends CartState {
  CartItemsCountState(int cartCount, double cartAmount) : super(cartCount, cartAmount);
}
