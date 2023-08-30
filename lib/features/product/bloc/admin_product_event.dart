part of 'admin_product_bloc.dart';

@immutable
abstract class AdminProductEvent extends Equatable{}

class AdminProductsLoadEvent extends AdminProductEvent {

  @override
  List<Object?> get props => [];
}


class AdminAddProductEvent extends AdminProductEvent {

  final Product newProduct;
  AdminAddProductEvent({required this.newProduct});
  
  @override
  List<Object?> get props => [newProduct];
}