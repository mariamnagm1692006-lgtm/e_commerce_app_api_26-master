import 'package:ecommerce_app_api_26/features/categories/presentation/data/categories_api/categories_api.dart';
import 'package:ecommerce_app_api_26/features/categories/presentation/widget/categorie_cart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit_categorie/categories_cubit.dart';
import '../../cubit_categorie/categories_state.dart';
import '../data/models/categorie_model.dart';
import 'categorie_products.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> categories = [
      {
        'name': 'Electronics',
        'icon': Icons.electrical_services_outlined,
        'color': Colors.orange,
      },
      {
        'name': 'Fashion',
        'icon': Icons.checkroom_outlined,
        'color': Colors.pink,
      },
      {'name': 'Home', 'icon': Icons.home_work_outlined, 'color': Colors.green},
      {
        'name': 'Books',
        'icon': Icons.menu_book_outlined,
        'color': Colors.purple,
      },
      {'name': 'Beauty', 'icon': Icons.face_outlined, 'color': Colors.red},
      {
        'name': 'Sports',
        'icon': Icons.sports_basketball_outlined,
        'color': Colors.blue,
      },
    ];

    return BlocProvider(
      create: (context) => CategoriesCubit()..getCategorie(),
      child: Scaffold(
        backgroundColor: Colors.grey.shade50,
        appBar: AppBar(
          title: const Text(
            'Categories',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
          ),
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
        ),
        body: BlocBuilder<CategoriesCubit,CateegorieState>(builder: (context, state) {
          if (state is CateegorieLoading) {
            return Center(child: CircularProgressIndicator());
          }
          if (state is CatogrieError) {
            return Center(
              child: Text(
                "Error",
                style: TextStyle(fontSize: 20, fontWeight: .bold),
              ),
            );
          }
          if(state is CateegorieSuccess){
                return GridView.builder(
                  padding: const EdgeInsets.all(16),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1.1,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                  ),
                  itemCount:state.categories.length ,
                  itemBuilder: (context, index) {
                    final category = categories[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => CategorieProducts(id: state.categories[index].id ?? 1),
                          ),
                        );
                      },
                      child: CategoryCard(
                        id: state.categories[index].id,
                        name: state.categories[index].name,
                        imageUrl: state.categories[index].image,
                      ),
                    );
                  },
                );

          }
          return SizedBox.shrink();
        },)
        // FutureBuilder(
        //   future: CategoriesApi().getAllCategories(),
        //   builder: (context, snapshot) {
        //     if (snapshot.connectionState == ConnectionState.waiting) {
        //       return Center(child: CircularProgressIndicator());
        //     }
        //     if (snapshot.hasError || snapshot.data == null) {
        //       return Center(
        //         child: Text(
        //           "Error",
        //           style: TextStyle(color: Colors.red, fontSize: 20),
        //         ),
        //       );
        //     }
        //     List<CategorieModel>? categories = snapshot.data;
        //     return GridView.builder(
        //       padding: const EdgeInsets.all(16),
        //       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        //         crossAxisCount: 2,
        //         childAspectRatio: 1.1,
        //         crossAxisSpacing: 16,
        //         mainAxisSpacing: 16,
        //       ),
        //       itemCount: categories!.length,
        //       itemBuilder: (context, index) {
        //         final category = categories[index];
        //         return GestureDetector(
        //           onTap: () {
        //             Navigator.of(context).push(
        //               MaterialPageRoute(
        //                 builder: (_) => CategorieProducts(id: category.id ?? 1),
        //               ),
        //             );
        //           },
        //           child: CategoryCard(
        //             id: category.id,
        //             name: category.name,
        //             imageUrl: category.image,
        //           ),
        //         );
        //       },
        //     );
        //   },
        // ),
      ),
    );
  }
}
