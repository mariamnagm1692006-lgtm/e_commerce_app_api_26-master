import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../home/data/models/prduct_model.dart';
import '../../../home/data/product_api/products_api.dart';
import '../../../home/presentation/widgets/product_card.dart';

class CategorieProducts extends StatelessWidget {
  const CategorieProducts ({super.key, required this.id});
  final int id;

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: FutureBuilder(future: ProductsApi().getProductByCategories(id), builder:  (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError || snapshot.data == null) {
          return Center(
            child: Text(
              "Error",
              style: TextStyle(color: Colors.red, fontSize: 20),
            ),
          );
        }
        List<ProductModel>products= snapshot.data??[];
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
              itemCount: products?.length,
              itemBuilder: (context, index) {
                final product = products![index];
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
      
      
      },),
    );
  }
}
