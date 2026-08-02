import 'package:ecommerce_app_api_26/features/home/cubit/product_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/models/prduct_model.dart';
import '../data/product_api/products_api.dart';



class ProductCubit extends Cubit<ProductState> {
  ProductCubit() : super(InitialState());
  ProductsApi product = ProductsApi();
  Future<void> getProduct() async {
    emit(ProductLoading());
    try {
      emit(ProductLoading());
      List<ProductModel> products = await product.getAllProducts();
      emit(ProductSuccess(products: products));
    } catch (e) {
      emit(ProductError(message: e.toString()));
    }
  }
}
