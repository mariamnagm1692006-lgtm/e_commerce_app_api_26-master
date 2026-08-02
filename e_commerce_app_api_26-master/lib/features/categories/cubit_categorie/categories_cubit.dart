import 'package:ecommerce_app_api_26/features/categories/cubit_categorie/categories_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../presentation/data/categories_api/categories_api.dart';
import '../presentation/data/models/categorie_model.dart';




class CategoriesCubit extends Cubit<CateegorieState> {
  CategoriesCubit() : super(CateegorieSInitial());
  CategoriesApi categoriesApi=CategoriesApi();
  Future<void> getCategorie() async {
    emit(CateegorieLoading());
    try {
      emit(CateegorieLoading());
      List<CategorieModel> categorie = await categoriesApi.getAllCategories();
      emit(CateegorieSuccess(categories: categorie));
    } catch (e) {
      emit(CatogrieError(message: e.toString()));
    }
  }
}
