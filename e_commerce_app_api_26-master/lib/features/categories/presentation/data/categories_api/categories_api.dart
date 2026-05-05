import 'dart:convert';

import 'package:ecommerce_app_api_26/core/endpoint/end_point.dart';
import 'package:http/http.dart' as http;

import '../models/categorie_model.dart';

class CategoriesApi {
 Future<List<CategorieModel>> getAllCategories()async{
    Uri url=Uri.parse(EndPoint.baseurl+EndPoint.categories);
    var response = await http.get(url);
    var json = jsonDecode(response.body) as List;
    List<CategorieModel> categories = json.map((val) {
      return CategorieModel.fromJson(val);
    }).toList();
    return categories;
  }
}