part of 'product_bloc.dart';

@immutable
abstract class ProductState {
  ProductState();
}

abstract class ProductActionState extends ProductState {}

class ProductInitial extends ProductState {}

class ProductAlteredInCartState extends ProductState {
}

class ProductAddedToCartState extends ProductAlteredInCartState {
}

class ProductRemovedFromCartState extends ProductAlteredInCartState {
}