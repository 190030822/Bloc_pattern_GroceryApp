part of 'cart_bloc.dart';

@immutable
abstract class CartEvent {}

class CartInitialEvent extends CartEvent{
  
}


class CartRemoveFromCartEvent extends CartEvent {
  final ProductDataModel cartItem;
  CartRemoveFromCartEvent({
    required this.cartItem,
  });
}

class CartItemAddedToCartEvent extends CartEvent {
  final ProductDataModel cartItem;
  CartItemAddedToCartEvent({
    required this.cartItem,
  });
}
