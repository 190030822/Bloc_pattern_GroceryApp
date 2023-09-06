import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc_tutorial/features/home/repos/items_repo.dart';
import 'package:flutter_bloc_tutorial/features/product/models/home_product_data_model.dart';
import 'package:meta/meta.dart';

part 'admin_product_event.dart';
part 'admin_product_state.dart';

class AdminProductBloc extends Bloc<AdminProductEvent, AdminProductState> {
  AdminProductBloc() : super(AdminProductInitial()) {
    on<AdminProductEvent>((event, emit) {
    });
    on<AdminProductsLoadEvent>(adminProductsLoadEvent);
    on<AdminAddProductEvent>(addNewProduct);
    on<AdminEditProductEvent>(editProduct);
    on<AdminDeleteProductEvent>(deleteProduct);
  }

  FutureOr<void> adminProductsLoadEvent(AdminProductsLoadEvent event, Emitter<AdminProductState> emit) async{
    try {
      List<Product> products = await ItemsRepo.adminFetchItems();
      emit(AdminProductsLoadedState(products: products));
    } catch(e) {
      emit(AdminProductsErrorState(errMsg: e.toString()));
    }
  }

  FutureOr<void> addNewProduct(AdminAddProductEvent event, Emitter<AdminProductState> emit) async {
    try {
      Product product = await ItemsRepo.addNewProduct(newProduct : event.newProduct);
      final state = this.state;
      emit(AdminAddProductSuccessState(successMsg: "Product ${product.name} added successfully"));
      if (state is AdminProductsLoadedState) {
        emit(AdminProductsLoadedState(products: List.from(state.products)..add(product)));
      }
    } catch (e) {
      AdminProductsErrorState(errMsg: e.toString());
    }
  }

  FutureOr<void> editProduct(AdminEditProductEvent event, Emitter<AdminProductState> emit) async {
    try {
      Product product = await ItemsRepo.editProduct(editProduct: event.editProduct);
      if (state is AdminProductsLoadedState) {
        final state = this.state as AdminProductsLoadedState;
        final products = state.products.where((productEle) => productEle.id != event.editProduct.id).toList();
        products.add(event.editProduct);
        emit(AdminAddProductSuccessState(successMsg: "Product ${product.name} edited successfully"));
        emit(AdminProductsLoadedState(products: products));
      }
    } catch(e) {
      AdminProductsErrorState(errMsg: e.toString());
    }
  }

  FutureOr<void> deleteProduct(AdminDeleteProductEvent event, Emitter<AdminProductState> emit) async {
    try {
      ItemsRepo.deleteProduct(delteProduct: event.deleteProduct);
      if (state is AdminProductsLoadedState) {
        final state = this.state as AdminProductsLoadedState;
        final products = state.products.where((productItem) => productItem.id != event.deleteProduct.id).toList();
        emit(AdminAddProductSuccessState(successMsg: "Product ${event.deleteProduct.name} delted successfully"));
        emit(AdminProductsLoadedState(products: products));
      }
    } catch (e) {
      AdminProductsErrorState(errMsg: e.toString());
    }
  }
}
