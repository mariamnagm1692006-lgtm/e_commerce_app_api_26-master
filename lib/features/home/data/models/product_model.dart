import 'package:ecommerce_app_api_26/features/categories/data/models/category_model.dart';

class ProductModel {
  int? id;
  String? title;
  int? price;
  String? description;
  CategoryModel? category;
  List<String>? images;

  ProductModel(
      {this.id,
        this.title,
        this.price,
        this.description,
        this.category,
        this.images,});

  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    price = json['price'];
    description = json['description'];
    category = json['category'] != null
        ? CategoryModel.fromJson(json['category'])
        : null;
    images = json['images'].cast<String>();
  }
}