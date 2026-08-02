
import '../presentation/data/models/categorie_model.dart';

abstract class CateegorieState {}

class CateegorieSInitial extends CateegorieState {}

class CateegorieLoading extends CateegorieState {}

class CateegorieSuccess extends CateegorieState {
  List<CategorieModel> categories;
  CateegorieSuccess({required this.categories});
}

class CatogrieError extends CateegorieState {
  String message;
  CatogrieError({required this.message});
}
