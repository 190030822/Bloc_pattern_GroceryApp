import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc_tutorial/features/product/models/home_product_data_model.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc() : super(ProductInitial()) {
    on<ProductEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<ProductCartActionEvent>(productCartActionEvent);
  }

  FutureOr<void> productCartActionEvent(ProductCartActionEvent event, Emitter<ProductState> emit) {
    emit(ProductCartActionState(productChanged: ProductDataModel.copyWith(event.productChanged)));
  }

  @override
  void onChange(Change<ProductState> change) {
    super.onChange(change);
    print(change);
  }
  
  @override
  void onError(Object error, StackTrace stackTrace) {
    print(error);
    super.onError(error, stackTrace);
  }
}
