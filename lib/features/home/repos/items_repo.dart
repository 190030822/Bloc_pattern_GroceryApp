


import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter_bloc_tutorial/features/product/models/home_product_data_model.dart';

class ItemsRepo {

  static final String baseUrl = "http://localhost:8080";
  static var client = http.Client();

  static Future<List<ProductDataModel>> fetchItems() async {

    // final headers = {
    //   'X-RapidAPI-Key': '5c3be384f8msh17483425c98d2d5p1ca71ajsn1b5e30a210e0',
    //   'X-RapidAPI-Host': 'edamam-food-and-grocery-database.p.rapidapi.com'
    // };

    // final params = {
    //   'nutrition-type': 'cooking',
    //   'category[0]': 'generic-foods',
    //   'health[0]': 'alcohol-free'
    // };

    try {
      final Uri url =  Uri.parse("${baseUrl}/getProducts");
      // url.replace(queryParameters: params);
      final response = await client.get(url);
      if (response.statusCode == 200) {
        final result = jsonDecode(response.body);
        List<ProductDataModel> data = [];
        for (int i = 0; i < result.length; i++) {
          data.add(ProductDataModel.fromJson(result[i]));
        }
        return data;
      } else {
        throw Exception("${response.statusCode} message");
      }
    } catch(e) {
      throw e;
    } 

  }

    static Future<List<Product>> adminFetchItems() async {

    // final headers = {
    //   'X-RapidAPI-Key': '5c3be384f8msh17483425c98d2d5p1ca71ajsn1b5e30a210e0',
    //   'X-RapidAPI-Host': 'edamam-food-and-grocery-database.p.rapidapi.com'
    // };

    // final params = {
    //   'nutrition-type': 'cooking',
    //   'category[0]': 'generic-foods',
    //   'health[0]': 'alcohol-free'
    // };

    try {
      final Uri url =  Uri.parse("${baseUrl}/getProducts");
      // url.replace(queryParameters: params);
      final response = await client.get(url);
      if (response.statusCode == 200) {
        final result = jsonDecode(response.body);
        List<Product> data = [];
        for (int i = 0; i < result.length; i++) {
          data.add(Product.fromJson(result[i]));
        }
        return data;
      } else {
        throw Exception("${response.statusCode} message");
      }
    } catch(e) {
      print(e);
      throw e;
    }

  }

  static Future<Product> addNewProduct({required Product newProduct}) async {
    try {
      final Uri url =  Uri.parse("${baseUrl}/addProduct");
      final response =  await client.post(
        url,
        headers: {
        "Content-Type": "application/json"
        },
       body: jsonEncode(newProduct.toJson())
      );
      if (response.statusCode == 200) {
        return Product.fromJson(jsonDecode(response.body));
      } else {
        throw Exception("${response.statusCode}");
      }
      
    } catch(e) {
      throw e;
    }
  }
}
