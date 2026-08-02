import 'package:ecommerce_app_api_26/features/categories/cubit_product_by_categorie/product_py_categorie_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../home/data/models/prduct_model.dart';
import '../../home/data/product_api/products_api.dart';




class ProductByCateegorieCubit extends Cubit<ProductPyCategorieState> {
  ProductByCateegorieCubit() : super(ProductPyCategorieInitial());
  ProductsApi productByCategorie=ProductsApi( );
  Future<void> getProductByCategories(int id) async {

    emit(ProductPyCategorieLoading());
    try {
      emit(ProductPyCategorieLoading());
      List<ProductModel> products = await productByCategorie.getAllProducts();
      emit(ProductPyCategorieSuccess(products: products));
    } catch (e) {
      emit(ProductPyCategorieError(message: e.toString()));
    }
  }
}
