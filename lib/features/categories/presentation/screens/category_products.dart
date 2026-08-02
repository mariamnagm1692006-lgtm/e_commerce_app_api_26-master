import 'package:flutter/material.dart';

import '../../../home/data/models/product_model.dart';
import '../../../home/data/products_api/products_api.dart';
import '../../../home/presentation/widgets/product_card.dart';

class CategoryProducts extends StatelessWidget {
  const CategoryProducts({super.key, required this.id});
  final int id;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: ProductsApi().getProductsByCategory(id),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError || snapshot.data == null) {
            return Center(
              child: Text(
                "Error",
                style: TextStyle(fontSize: 25, color: Colors.red),
              ),
            );
          }
          List<ProductModel>? products = snapshot.data;
          return SingleChildScrollView(
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
                itemCount: products!.length,
                itemBuilder: (context, index) {
                  final product = products[index];
                  return ProductCard(
                    title: product.title,
                    price: product.price,
                    description: product.description,
                    image: product.images![0],
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
