part of 'cart_bloc.dart';

@immutable
abstract class CartState {
  final double cartAmount;
  CartState(this.cartAmount);
}

abstract class CartActionState extends CartState {  
  CartActionState(double cartAmount) : super(cartAmount);
}

class CartInitial extends CartState {
  final List<ProductDataModel> cartItems;
  CartInitial(double cartAmount, {
    required this.cartItems,
  }): super(cartAmount);
}

class CartSuccessState extends CartState {
  final List<ProductDataModel> cartItems;
  CartSuccessState(double cartAmount, {
    required this.cartItems,
  }) : super(cartAmount);
}

