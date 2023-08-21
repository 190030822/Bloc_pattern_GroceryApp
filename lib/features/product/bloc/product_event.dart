part of 'product_bloc.dart';

@immutable
abstract class ProductEvent {}

class ProductAddedToCartEvent extends ProductEvent {
  final ProductDataModel product;
  ProductAddedToCartEvent(this.product);
}

class ProductRemovedFromCartEvent extends ProductEvent {
  final ProductDataModel product;
  ProductRemovedFromCartEvent(this.product);
}

