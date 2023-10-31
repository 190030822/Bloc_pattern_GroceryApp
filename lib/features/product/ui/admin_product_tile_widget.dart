import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_tutorial/constants.dart';
import 'package:flutter_bloc_tutorial/features/product/bloc/admin_product_bloc.dart';
import 'package:flutter_bloc_tutorial/features/product/models/home_product_data_model.dart';

class ProductsList extends StatelessWidget {
  final Product product;
  const ProductsList({super.key, required this.product});

  @override
  Widget build(BuildContext context) {

    AdminProductBloc adminProductBloc = BlocProvider.of<AdminProductBloc>(context);

    return Card(
      elevation: 2,
      child: ListTile(
        leading: Container(
          height: 50,
          width: 50,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: Image.network('${product.imageUrl}'),
          ),
        ),
        title: Text(product.name),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
          IconButton(onPressed: () {
            Navigator.pushNamed(context, '/adminAddNewProduct');
          }, icon: Icon(Icons.edit)),
          IconButton(onPressed: () => adminProductBloc.add(AdminDeleteProductEvent(deleteProduct: product)), icon: Icon(Icons.delete))
        ]),
      ),
    );
  }
}