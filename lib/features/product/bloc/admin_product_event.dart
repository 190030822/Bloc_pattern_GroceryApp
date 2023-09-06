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

class AdminEditProductEvent extends AdminProductEvent {

  final Product editProduct;
  AdminEditProductEvent({required this.editProduct});
  
  @override
  List<Object?> get props => [editProduct];
}

class AdminDeleteProductEvent extends AdminProductEvent {

  final Product deleteProduct;
  AdminDeleteProductEvent({required this.deleteProduct});
  
  @override
  List<Object?> get props => [deleteProduct];


}