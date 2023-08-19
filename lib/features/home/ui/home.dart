import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_tutorial/features/cart/bloc/cart_bloc.dart';
import 'package:flutter_bloc_tutorial/features/cart/ui/cart.dart';
import 'package:flutter_bloc_tutorial/features/home/bloc/home_bloc.dart';
import 'package:flutter_bloc_tutorial/features/home/ui/product_tile_widget.dart';
import 'package:flutter_bloc_tutorial/features/wishlist/ui/wishlist.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late HomeBloc homeBloc;
  // late CartBloc

  @override
  void initState() {
    homeBloc = BlocProvider.of<HomeBloc>(context);
    homeBloc.add(HomeInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      bloc: homeBloc,
      listenWhen: (previous, current) => current is HomeActionState,
      buildWhen: (previous, current) => current is! HomeActionState,
      listener: (context, state) {
        if (state is HomeNavigateToCartPageActionState) {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Cart()));
        } else if (state is HomeNavigateToWishlistPageActionState) {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Wishlist()));
        } else if (state is HomeProductItemCartedActionState) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Item Carted'),
            duration: Duration(milliseconds: 300),
          ));
        } else if (state is HomeProductItemWishlistedActionState) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Item Wishlisted'),
            duration: Duration(milliseconds: 300),
          ));
        }
      },
      builder: (context, state) {
        print("______1__${state.runtimeType}");
        switch (state.runtimeType) {
          case HomeLoadingState:
            return Scaffold(
                body: Center(
              child: CircularProgressIndicator(),
            ));
          case HomeLoadedSuccessState:
            final successState = state as HomeLoadedSuccessState;
            return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.teal,
                title: Text('ALL MIX Grocery App'),
                actions: [
                  IconButton(
                      onPressed: () {
                        homeBloc.add(HomeWishlistButtonNavigateEvent());
                      },
                      icon: Icon(Icons.favorite_border)),
                  Stack(
                    alignment: AlignmentDirectional.center,
                    children: [
                      IconButton(
                          onPressed: () {
                            homeBloc.add(HomeCartButtonNavigateEvent());
                          },
                          icon: Icon(Icons.shopping_bag_outlined)),
                      Positioned(
                        bottom: 30,
                        left: 20,
                        child: CircleAvatar(
                          radius: 10,
                          child: BlocBuilder<CartBloc, CartState>(
                            buildWhen: (previous, current) =>
                                current.runtimeType == CartItemsCountState,
                            builder: (context, state) {
                              if (state.runtimeType == CartItemsCountState) {
                                CartItemsCountState countState =
                                    state as CartItemsCountState;
                                return Text("${countState.cartCount}");
                              }
                              return Text("0");
                            },
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: null,
                child: BlocBuilder<CartBloc, CartState>(
                  buildWhen: (previous, current) => current.runtimeType == CartItemsCountState,
                  builder: (context, state) {
                    return Text("${state.cartAmount}");
                  },
                ),
              ),
              body: ListView.builder(
                  itemCount: successState.products.length,
                  itemBuilder: (context, index) {
                    return ProductTileWidget(
                      productDataModel: successState.products[index],
                      state: successState,
                    );
                  }),
            );

          case HomeErrorState:
            final homeErrorSate = state as HomeErrorState;
            return Scaffold(
                body: Center(child: Text('${homeErrorSate.errorMessage}')));
          default:
            return SizedBox();
        }
      },
    );
  }
}
