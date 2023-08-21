


import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter_bloc_tutorial/features/product/models/home_product_data_model.dart';

class ItemsRepo {

  static var client = http.Client();
  static Future<List<ProductDataModel>> fetchItems() async {

    final headers = {
      'X-RapidAPI-Key': '5c3be384f8msh17483425c98d2d5p1ca71ajsn1b5e30a210e0',
      'X-RapidAPI-Host': 'edamam-food-and-grocery-database.p.rapidapi.com'
    };

    final params = {
      'nutrition-type': 'cooking',
      'category[0]': 'generic-foods',
      'health[0]': 'alcohol-free'
    };

    try {
      final Uri url =  Uri.parse("https://edamam-food-and-grocery-database.p.rapidapi.com/api/food-database/v2/parser");
      url.replace(queryParameters: params);
      final response = await client.get(url, headers: headers);
      if (response.statusCode == 200) {
        final result = jsonDecode(response.body);
        List<ProductDataModel> data = [];
        for (int i = 0; i < result["hints"].length; i++) {
          data.add(ProductDataModel.fromJson(result["hints"][i]["food"]));
        }
        return data;
      } else {
        throw Exception("${response.statusCode} message");
      }
    } catch(e) {
      rethrow;
    }

  }
}
