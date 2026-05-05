import 'dart:convert';

import 'package:ecommerce_app_api_26/core/endpoint/end_point.dart';
import 'package:ecommerce_app_api_26/features/home/data/models/prduct_model.dart';
import 'package:http/http.dart' as http;

class ProductsApi {
  Future<List<ProductModel>> getAllProducts() async {
    Uri url = Uri.parse(EndPoint.baseurl + EndPoint.Products);
    var response = await http.get(url);
    var json = jsonDecode(response.body) as List;
    List<ProductModel> products = json.map((val) {
      return ProductModel.fromJson(val);
    }).toList();
    return products;
  }


  Future<List<ProductModel>>getProductByCategories(int categoryId)async{
    Uri url = Uri.parse(EndPoint.baseurl + EndPoint.Products+"?categoryId=$categoryId");
    var response = await http.get(url);
    var json = jsonDecode(response.body) as List;
    List<ProductModel> products = json.map((val) {
      return ProductModel.fromJson(val);
    }).toList();
    return products;
  }
}
