import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc_tutorial/data/cart_items.dart';
import 'package:flutter_bloc_tutorial/features/product/models/home_product_data_model.dart';
import 'package:meta/meta.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final CartRepo cartRepo;
  ProductBloc(this.cartRepo) : super(ProductInitial()) {
   on<ProductAddedToCartEvent>(productAddedToCartEvent);
   on<ProductRemovedFromCartEvent>(productRemovedFromCartEvent);
  }

  FutureOr<void> productAddedToCartEvent(ProductAddedToCartEvent event, Emitter<ProductState> emit) {
    event.product.quantityInCart +=1;
    cartRepo.addItemToCart(event.product);
    emit(ProductAddedToCartState());
  }

  FutureOr<void> productRemovedFromCartEvent(ProductRemovedFromCartEvent event, Emitter<ProductState> emit) {
    event.product.quantityInCart -=1;
    cartRepo.removeItemFromCart(event.product);
    emit(ProductRemovedFromCartState());
  }
}
