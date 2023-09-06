import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc_tutorial/features/product/models/home_product_data_model.dart';
import 'package:meta/meta.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {

  static Map<String, ProductDataModel> _cartItems = {}; 

  CartBloc(): super(CartSuccessState(0, cartItems: [])) {
    on<CartInitialEvent>(cartInitialEvent);
    on<CartRemoveFromCartEvent>(cartRemoveFromCartEvent);
    on<CartItemAddedToCartEvent>(cartItemAddedToCartEvent);
  }

  FutureOr<void> cartInitialEvent(CartInitialEvent event, Emitter<CartState> emit) {
    if (state.runtimeType == CartSuccessState) {
      CartSuccessState state = this.state as CartSuccessState;
      emit(CartSuccessState(state.cartAmount, cartItems: state.cartItems));
    }
  }

  FutureOr<void> cartRemoveFromCartEvent(
      CartRemoveFromCartEvent event, Emitter<CartState> emit) {
        event.cartItem.quantityInCart -= 1;
        if (state.runtimeType == CartSuccessState) {
          CartSuccessState state = this.state as CartSuccessState;
          double cartAmount = state.cartAmount;
          cartAmount -= event.cartItem.price;
          cartAmount = double.parse(cartAmount.toStringAsFixed(2));
          emit(CartSuccessState(cartAmount, cartItems: removeItem(event, state)));
        }
  }

  List<ProductDataModel> removeItem(CartRemoveFromCartEvent event, CartSuccessState state) {
    List<ProductDataModel> cartItems;
    if (event.cartItem.quantityInCart == 0) {
      cartItems = List.from(state.cartItems)..remove(event.cartItem);
      CartBloc._cartItems.remove(event.cartItem.id);
    } else {
      cartItems = List.from(state.cartItems);
    }
    return cartItems;
  }

  FutureOr<void> cartItemAddedToCartEvent(CartItemAddedToCartEvent event, Emitter<CartState> emit) {
    event.cartItem.quantityInCart +=1;
    if (state.runtimeType == CartSuccessState) {
      CartSuccessState state = this.state as CartSuccessState;
      double cartAmount = state.cartAmount;
      cartAmount += event.cartItem.price;
      cartAmount = double.parse(cartAmount.toStringAsFixed(2));
      emit(CartSuccessState(cartAmount, cartItems: addItem(event, state)));
    }
  }

  List<ProductDataModel> addItem(CartItemAddedToCartEvent event, CartSuccessState state) {
    List<ProductDataModel> cartItems;
    if (!CartBloc._cartItems.containsKey(event.cartItem.id)) {
      cartItems = List.from(state.cartItems)..add(event.cartItem);
      CartBloc._cartItems[event.cartItem.id] = event.cartItem;
    } else {
      cartItems = List.from(state.cartItems);
    }
    return cartItems;
  }


}
