import 'package:ecommerce_app_api_26/features/home/data/models/prduct_model.dart';

abstract class ProductPyCategorieState {}

class ProductPyCategorieInitial extends ProductPyCategorieState {}

class ProductPyCategorieLoading extends ProductPyCategorieState {}

class ProductPyCategorieSuccess extends ProductPyCategorieState {
  List<ProductModel> products;
  ProductPyCategorieSuccess({required this.products});
}

class ProductPyCategorieError extends ProductPyCategorieState {
  String message;
  ProductPyCategorieError({required this.message});
}
