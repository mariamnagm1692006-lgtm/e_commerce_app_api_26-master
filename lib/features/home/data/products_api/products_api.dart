import 'dart:convert';

import 'package:ecommerce_app_api_26/core/api/end_points.dart';
import 'package:ecommerce_app_api_26/features/home/data/models/product_model.dart';
import 'package:http/http.dart' as http;

class ProductsApi {
  Future<List<ProductModel>> getAllProducts() async {
    Uri url = Uri.parse(EndPoints.baseUrl + EndPoints.allProducts);

    var response = await http.get(url);
    List<dynamic> json = jsonDecode(response.body) as List;

    List<ProductModel> products = json.map((element) {
      return ProductModel.fromJson(element);
    }).toList();

    return products;
  }

  Future<List<ProductModel>> getProductsByCategory(int categoryId) async {
    Uri url = Uri.parse(
      EndPoints.baseUrl + EndPoints.allProducts + "?categoryId=$categoryId",
    );

    var response = await http.get(url);
    List<dynamic> json = jsonDecode(response.body) as List;

    List<ProductModel> products = json.map((element) {
      return ProductModel.fromJson(element);
    }).toList();

    return products;
  }
}
