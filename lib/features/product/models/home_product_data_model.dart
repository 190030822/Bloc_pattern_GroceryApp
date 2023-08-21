class ProductDataModel {
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
  });

  ProductDataModel.copy(this.id, this.name, this.description, this.price, this.imageUrl, this.quantityInCart, this.inStockCount);

  factory ProductDataModel.fromJson(dynamic json) {
    return new ProductDataModel(
      id: json["foodId"],
      name: json["label"],
      description: json["knownAs"],
      price: json["nutrients"]["ENERC_KCAL"],
      imageUrl: json["image"] ?? "https://cdn.shopify.com/s/files/1/0258/4307/3103/products/asset_2_800x.jpg?v=1571839043",
      quantityInCart: 0,
      inStockCount: 10
    );
  }
}
