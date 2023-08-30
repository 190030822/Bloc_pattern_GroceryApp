import 'package:flutter/material.dart';
import 'package:flutter_bloc_tutorial/features/product/models/home_product_data_model.dart';

class ProductsList extends StatelessWidget {
  final Product product;
  const ProductsList({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        child: Image.network('${product.imageUrl}'),
      ),
      title: Text(product.name),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
        IconButton(onPressed: null, icon: Icon(Icons.edit)),
        IconButton(onPressed: null, icon: Icon(Icons.delete))
      ]),
    );
  }
}