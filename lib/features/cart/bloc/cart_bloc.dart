import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc_tutorial/data/cart_items.dart';
import 'package:flutter_bloc_tutorial/features/product/models/home_product_data_model.dart';
import 'package:meta/meta.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final CartRepo cartRepo;

  CartBloc(this.cartRepo): super(CartInitial()) {
    on<CartInitialEvent>(cartInitialEvent);
    on<CartRemoveFromCartEvent>(cartRemoveFromCartEvent);
    on<CartItemsCountEvent>(cartItemsCountEvent);
  }

  FutureOr<void> cartInitialEvent(
      CartInitialEvent event, Emitter<CartState> emit) {
    emit(CartSuccessState(state.cartCount, state.cartAmount, cartItems: cartRepo.cartItems.values.toList()));
  }

  FutureOr<void> cartRemoveFromCartEvent(
      CartRemoveFromCartEvent event, Emitter<CartState> emit) {
    emit(CartRemoveItemMessageActionState(state.cartCount, state.cartAmount, event.productDataModel));
    emit(CartSuccessState(state.cartCount, state.cartAmount, cartItems: cartRepo.cartItems.values.toList()));
  }

  FutureOr<void> cartItemsCountEvent(CartItemsCountEvent event, Emitter<CartState> emit) {
    if (event.cartAmount < 0) {
      emit(CartItemsCountState(state.cartCount-1, state.cartAmount + event.cartAmount));
    } else {
      emit(CartItemsCountState(state.cartCount+1, state.cartAmount + event.cartAmount));
    }
  }
}
