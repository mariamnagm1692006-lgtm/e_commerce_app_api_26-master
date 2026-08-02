import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../home/presentation/widgets/product_card.dart';
import '../../cubit_product_by_categorie/product_by_cateegorie_cubit.dart';
import '../../cubit_product_by_categorie/product_py_categorie_state.dart';

class CategorieProducts extends StatelessWidget {
  const CategorieProducts ({super.key, required this.id});
  final int id;

  @override
  Widget build(BuildContext context) {
    return  BlocProvider(
      create: (context) => ProductByCateegorieCubit()..getProductByCategories(id),
      child: Scaffold(


        body: BlocBuilder<ProductByCateegorieCubit,ProductPyCategorieState>(builder: (context, state) {

          if (state is ProductPyCategorieLoading) {
            return Center(child: CircularProgressIndicator());
          }
          if (state is ProductPyCategorieError) {
            return Center(
              child: Text(
                "Error",
                style: TextStyle(fontSize: 20, fontWeight: .bold),
              ),
            );
        }
          if(state is ProductPyCategorieSuccess){
            return  SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.7,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                  ),
                  itemCount:state.products.length,
                  itemBuilder: (context, index) {
                    final product = state.products[index];
                    return ProductCard(
                      title: product.title?? "No Title",
                      price: (product.price ?? 0).toDouble(),
                      description: product.description??"",
                      image: product.images![0],
                      /////////////
                      id: product.id,
                    );
                  },
                ),
          ),
          );

          }
          return SizedBox.shrink();
    })

      ),
    );
  }
}
