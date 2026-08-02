import 'package:ecommerce_app_api_26/features/home/data/models/prduct_model.dart';

abstract class ProductState {}

class InitialState extends ProductState {}

class ProductLoading extends ProductState {}

class ProductSuccess extends ProductState {
  List<ProductModel> products;
  ProductSuccess({required this.products});
}

class ProductError extends ProductState {
  String message;
  ProductError({required this.message});
}
