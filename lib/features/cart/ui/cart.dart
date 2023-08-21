import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_tutorial/features/cart/bloc/cart_bloc.dart';
import 'package:flutter_bloc_tutorial/features/product/ui/product_tile_widget.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {

  late CartBloc cartBloc;

  @override
  void initState() {
    cartBloc = BlocProvider.of<CartBloc>(context, listen: false);
    cartBloc.add(CartInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart Items'),
      ),
      body: BlocConsumer<CartBloc, CartState>(
        bloc: cartBloc,
        listener: (context, state) {
          if (state.runtimeType == CartRemoveItemMessageActionState) {
            final cartRemovedItemState = state as CartRemoveItemMessageActionState;
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(" ${cartRemovedItemState.removedItem.name} Item removed Successfully")));
          } 
        },
        listenWhen: (previous, current) => current is CartActionState,
        buildWhen: (previous, current) => current.runtimeType == CartSuccessState,
        builder: (context, state) {
          if (state.runtimeType == CartSuccessState) {
            final successState = state as CartSuccessState;
            return ListView.builder(
              itemCount: successState.cartItems.length,
              itemBuilder: (context, index) {
                return ProductTileWidget(
                  productDataModel: successState.cartItems[index],
                  state: successState,
                );
              }
            );
          } else {
            return SizedBox();
          }
        },
      ),
    );
  }
}
