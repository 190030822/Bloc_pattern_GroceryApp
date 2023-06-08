part of 'cart_bloc.dart';

@immutable
abstract class CartState {
  CartState();
}

abstract class CartActionState extends CartState {  
}

class CartInitial extends CartState {
}

class CartSuccessState extends CartState {
  final List<ProductDataModel> cartItems;
  CartSuccessState({
    required this.cartItems,
  });
}

class CartRemoveItemMessageState extends CartActionState {
  final ProductDataModel removedItem;
  CartRemoveItemMessageState(this.removedItem);
}

class CartItemsCountState extends CartState {
  final int cartCount;
  CartItemsCountState(this.cartCount);
}
