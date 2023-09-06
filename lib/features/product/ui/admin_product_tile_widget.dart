import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_tutorial/features/product/bloc/admin_product_bloc.dart';
import 'package:flutter_bloc_tutorial/features/product/models/home_product_data_model.dart';
import 'package:flutter_bloc_tutorial/features/product/ui/admin_add_new_product.dart';

class ProductsList extends StatelessWidget {
  final Product product;
  const ProductsList({super.key, required this.product});

  @override
  Widget build(BuildContext context) {

    AdminProductBloc adminProductBloc = BlocProvider.of<AdminProductBloc>(context);

    return ListTile(
      leading: CircleAvatar(
        child: Image.network('${product.imageUrl}'),
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
    );
  }
}