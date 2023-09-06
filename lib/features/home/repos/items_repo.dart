


import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter_bloc_tutorial/features/product/models/home_product_data_model.dart';

class ItemsRepo {

  static final String baseUrl = "http://localhost:8080";
  static var client = http.Client();

  static Future<List<ProductDataModel>> fetchItems() async {

    try {
      final Uri url =  Uri.parse("${baseUrl}/getProducts");
      final response = await client.get(url);
      if (response.statusCode == 200) {
        final result = jsonDecode(response.body);
        List<ProductDataModel> data = [];
        for (int i = 0; i < result.length; i++) {
          data.add(ProductDataModel.fromJson(result[i]));
        }
        return data;
      } else {
        throw Exception("${response.body} message");
      }
    } catch(e) {
      throw e;
    } 

  }

    static Future<List<Product>> adminFetchItems() async {

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
        throw Exception("${response.body} message");
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
        throw Exception("${response.body}");
      }
      
    } catch(e) {
      throw e;
    }
  }

  static Future<Product> editProduct({required Product editProduct}) async {
    try {
      final Uri url = Uri.parse("${baseUrl}/updateProduct/${int.parse(editProduct.id)}");
      final http.Response response = await client.put(url,
        headers: {
          "Content-type" : "application/json"
        },
        body: jsonEncode(editProduct.toJson())
      );
      if (response.statusCode == 200) {
        return Product.fromJson(jsonDecode(response.body));
      } else {
        throw Exception(response.body);
      }
    } catch(e) {
      throw e;
    }
  }

  static FutureOr<void> deleteProduct({required Product delteProduct}) async {
    try {
      final Uri url = Uri.parse("${baseUrl}/deleteProduct/${int.parse(delteProduct.id)}");
      final http.Response response = await client.delete(url,
        headers: {
          "Content-type" : "application/json"
        },
        body: jsonEncode(delteProduct.toJson())
      );
      if (response.statusCode == 200) {
        return;
      } else {
        throw Exception(response.body);
      }
    } catch (e) {
      throw e;
    }
  }
}
