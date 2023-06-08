class ProductDataModel {
  final String id;
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  ProductDataModel({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
  });

  factory ProductDataModel.fromJson(dynamic json) {
    return new ProductDataModel(
      id: json["foodId"],
      name: json["label"],
      description: json["knownAs"],
      price: json["nutrients"]["ENERC_KCAL"],
      imageUrl: json["image"] ?? "https://cdn.shopify.com/s/files/1/0258/4307/3103/products/asset_2_800x.jpg?v=1571839043",
    );
  }
}
