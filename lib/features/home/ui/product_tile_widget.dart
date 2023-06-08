import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_tutorial/features/cart/bloc/cart_bloc.dart';
import 'package:flutter_bloc_tutorial/features/home/bloc/home_bloc.dart';
import 'package:flutter_bloc_tutorial/features/home/models/home_product_data_model.dart';

class ProductTileWidget extends StatelessWidget {
  final ProductDataModel productDataModel;
  final state;
  const ProductTileWidget(
      {super.key, required this.productDataModel, required this.state});

  @override
  Widget build(BuildContext context) {
    HomeBloc homeBloc = BlocProvider.of<HomeBloc>(context, listen: false);
    CartBloc cartBloc = BlocProvider.of<CartBloc>(context, listen: false);

    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.black)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 200,
            width: double.maxFinite,
            child: Image.network(productDataModel.imageUrl, fit: BoxFit.cover,),
          ),
          const SizedBox(height: 20),
          Text(productDataModel.name,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          Text(productDataModel.description),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("\$" + productDataModel.price.toString(),
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              Row(
                children: [
                  IconButton(
                      onPressed: () {
                        homeBloc.add(HomeProductWishlistButtonClickedEvent(
                            clickedProduct: productDataModel));
                      },
                      icon: Icon(Icons.favorite_border)),
                  IconButton(
                      onPressed: () {
                        if (state.runtimeType == CartSuccessState) {
                          cartBloc.add(CartRemoveFromCartEvent(productDataModel: productDataModel));
                          cartBloc.add(CartItemsCountEvent());
                        }
                        else if (state.runtimeType == HomeLoadedSuccessState) {
                          homeBloc.add(HomeProductCartButtonClickedEvent(
                            clickedProduct: productDataModel));
                          cartBloc.add(CartItemsCountEvent());
                        }
                      },
                      icon: selectIcon(),
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }


  Icon selectIcon() {
    switch(state.runtimeType) {
      case CartSuccessState: return Icon(Icons.shopping_bag);
      case HomeLoadedSuccessState: return Icon(Icons.shopping_bag_outlined);
      default: return Icon(Icons.shopping_bag_outlined);
    }
  }


}
