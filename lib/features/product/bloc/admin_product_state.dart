part of 'admin_product_bloc.dart';

@immutable
abstract class AdminProductState {}

abstract class AdminProductListenState extends AdminProductState {}

class AdminProductInitial extends AdminProductState {}

class AdminProductsErrorState extends AdminProductListenState {
  final String errMsg;
  AdminProductsErrorState({required this.errMsg});
}

class AdminProductsLoadedState extends AdminProductState {
  final List<Product> products;
  AdminProductsLoadedState({required this.products}) {}
}


class AdminAddProductSuccessState extends AdminProductListenState {
  final String successMsg;
  AdminAddProductSuccessState({required this.successMsg});
}

