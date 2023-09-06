import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_tutorial/features/cart/bloc/cart_bloc.dart';
import 'package:flutter_bloc_tutorial/features/home/bloc/home_bloc.dart';
import 'package:flutter_bloc_tutorial/features/product/bloc/bloc/product_bloc.dart';
import 'package:flutter_bloc_tutorial/features/product/models/home_product_data_model.dart';

class ProductTileWidget extends StatelessWidget {
  final ProductDataModel productDataModel;
  final state;
  const ProductTileWidget(
      {super.key, required this.productDataModel, required this.state});

  @override
  Widget build(BuildContext context) {
    HomeBloc homeBloc = BlocProvider.of<HomeBloc>(context, listen: false);
    CartBloc cartBloc = BlocProvider.of<CartBloc>(context, listen: false);
    ProductBloc productBloc = BlocProvider.of<ProductBloc>(context, listen: false);

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
              BlocBuilder<ProductBloc, ProductState>(
                bloc: productBloc,
                buildWhen:(previous, current) {
                  if (current.runtimeType == ProductCartActionState) {
                    ProductCartActionState currState = current as ProductCartActionState;
                    if (currState.productChanged.id == productDataModel.id) {
                      return true;
                    } else {
                      return false;
                    }
                  }
                  return true;
                },
                builder: (context, productState) {
                  switch(productState.runtimeType) {
                    case ProductCartActionState : {
                      if (productDataModel.quantityInCart == 0) {
                        return TextButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll(Colors.orange),
                          ),
                          onPressed: () {
                            cartBloc.add(CartItemAddedToCartEvent(cartItem: productDataModel));
                            productBloc.add(ProductCartActionEvent(productChanged: productDataModel));
                          },
                          child: Text("ADD", style: TextStyle(color: Colors.black),),
                        );
                      } else {
                        return Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                cartBloc.add(CartRemoveFromCartEvent(cartItem : productDataModel));
                                productBloc.add(ProductCartActionEvent(productChanged: productDataModel));
                              }, 
                              icon: Icon(Icons.remove_circle_outline, color: Colors.red,)
                            ),
                            Text("${productDataModel.quantityInCart}"),
                            IconButton(
                              onPressed: () {
                                cartBloc.add(CartItemAddedToCartEvent(cartItem: productDataModel));
                                productBloc.add(ProductCartActionEvent(productChanged: productDataModel));
                              }, 
                              icon: Icon(Icons.add_circle_outline_outlined, color: Colors.green,)
                            ),
                          ],
                        );
                      }
                    }
                    case ProductInitial : {
                      return TextButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll(Colors.orange),
                        ),
                        onPressed: () {
                          cartBloc.add(CartItemAddedToCartEvent(cartItem: productDataModel));
                          productBloc.add(ProductCartActionEvent(productChanged: productDataModel));
                        },
                        child: Text("ADD", style: TextStyle(color: Colors.black),),
                      );
                    }
                    default: return SizedBox();
                  }
                } 
              ),
              IconButton(
                  onPressed: () {
                    homeBloc.add(HomeProductWishlistButtonClickedEvent(
                        clickedProduct: productDataModel));
                  },
                  icon: Icon(Icons.favorite_border)
              ),
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
