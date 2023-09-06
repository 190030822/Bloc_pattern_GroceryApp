part of 'product_bloc.dart';

abstract class ProductState extends Equatable {
  const ProductState();
  
  @override
  List<Object> get props => [];
}

class ProductInitial extends ProductState {}

class ProductCartActionState extends ProductState {
  
  final ProductDataModel productChanged;
  ProductCartActionState({required this.productChanged});

   @override
  List<Object> get props => ["${productChanged.id}${productChanged.quantityInCart}"];
}