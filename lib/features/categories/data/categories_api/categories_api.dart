import 'dart:convert';

import 'package:ecommerce_app_api_26/core/api/end_points.dart';
import 'package:ecommerce_app_api_26/features/categories/data/models/category_model.dart';
import 'package:http/http.dart' as http;

class CategoriesApi {
  Future<List<CategoryModel>> getAllCategories()async{
    Uri url = Uri.parse(EndPoints.baseUrl+EndPoints.allCategories);

    var response =await http.get(url);
    List<dynamic> json = jsonDecode(response.body) as List;

    List<CategoryModel> categories = json.map((element){
      return CategoryModel.fromJson(element);
    }).toList();

    return categories;
  }

}