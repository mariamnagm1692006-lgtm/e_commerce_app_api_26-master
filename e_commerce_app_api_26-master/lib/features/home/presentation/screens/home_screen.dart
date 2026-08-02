import 'package:ecommerce_app_api_26/features/home/cubit/product_state.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_app_api_26/features/home/presentation/widgets/product_card.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../cubit/product_cubit.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> dummyProducts = List.generate(
      10,
      (index) => {
        'id': index,
        'title': 'Product ${index + 1}',
        'description': 'Modern design for daily life',
        'price': (index + 1) * 20.0,
        'image': 'https://via.placeholder.com/150',
      },
    );

    return BlocProvider(
      create: (context) => ProductCubit()..getProduct(),
      child: Scaffold(
        backgroundColor: Colors.grey.shade50,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          toolbarHeight: 80,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Welcome,',
                    style: TextStyle(color: Colors.grey.shade600, fontSize: 14),
                  ),
                  const Text(
                    'Our Shop',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: IconButton(
                  icon: const Icon(
                    Icons.notifications_none,
                    color: Colors.blue,
                  ),
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              // Search Bar
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: const TextField(
                    decoration: InputDecoration(
                      hintText: 'Search products...',
                      border: InputBorder.none,
                      icon: Icon(Icons.search, color: Colors.blue),
                    ),
                  ),
                ),
              ),
              // Categories

              // Products Grid
              BlocBuilder<ProductCubit, ProductState>(
                builder: (context, state) {
                  if (state is ProductLoading) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (state is ProductError) {
                    return Center(
                      child: Text(
                        "Error",
                        style: TextStyle(fontSize: 20, fontWeight: .bold),
                      ),
                    );
                  }
                  if (state is ProductSuccess) {
                    return Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 0.7,
                              crossAxisSpacing: 16,
                              mainAxisSpacing: 16,
                            ),
                        itemCount: state.products.length,
                        itemBuilder: (context, index) {
                          final product = state.products[index];
                          return ProductCard(
                            title: product.title ?? "No Title",
                            price: (product.price ?? 0).toDouble(),
                            description: product.description ?? "",
                            image: product.images![0],
                            id: product.id,
                          );
                        },
                      ),
                    );
                  }
                  return SizedBox.shrink();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
