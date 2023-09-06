part of 'product_bloc.dart';

abstract class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object> get props => [];
}

class ProductCartActionEvent extends ProductEvent {
  
  final ProductDataModel productChanged;
  ProductCartActionEvent({required this.productChanged});

  @override
  List<Object> get props => ["${productChanged.id}${productChanged.quantityInCart}"];

}