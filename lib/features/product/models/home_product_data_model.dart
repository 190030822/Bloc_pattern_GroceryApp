import 'package:equatable/equatable.dart';

class Product extends Equatable{
  final String id;
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  final int inStockCount;

  Product({required this.id, required this.name, required this.description, required this.price, required this.imageUrl, required this.inStockCount});

    factory Product.fromJson(dynamic json) {
    return new Product(
      id: json["id"].toString(),
      name: json["name"],
      description: json["description"],
      price: json["price"],
      imageUrl: json["imageUrl"] ?? "https://cdn.shopify.com/s/files/1/0258/4307/3103/products/asset_2_800x.jpg?v=1571839043",
      inStockCount: json["inStockCount"] ?? 10,
    );
  }

  dynamic toJson() {
    return {
      "name": this.name,
      "description": this.description,
      "price": this.price,
      "imageUrl": this.imageUrl,
      "inStockCount" : this.inStockCount,
    };
  }
  
  @override
  List<Object?> get props => [id, name, description, price, imageUrl];

}


class ProductDataModel extends Product{
  final String id;
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  int quantityInCart;
  int inStockCount;

  ProductDataModel({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.quantityInCart,
    required this.inStockCount,
  }) : super(id: id, name: name, description: description, price: price, imageUrl: imageUrl, inStockCount: inStockCount);

  factory ProductDataModel.fromJson(dynamic json) {
    return ProductDataModel(
      id: json["id"].toString(),
      name: json["name"],
      description: json["description"],
      price: json["price"],
      imageUrl: json["imageUrl"] ?? "https://cdn.shopify.com/s/files/1/0258/4307/3103/products/asset_2_800x.jpg?v=1571839043",
      quantityInCart: 0,
      inStockCount: 10
    );
  }

  factory ProductDataModel.defaultValues() {
    return ProductDataModel(
      id: "", 
      name: "", 
      description: "", 
      price: 0.0, 
      imageUrl: "",
      quantityInCart: 0,
      inStockCount: 10);
  }

  @override
  List<Object?> get props => [id, name, description, price, imageUrl, quantityInCart, inStockCount];
}
