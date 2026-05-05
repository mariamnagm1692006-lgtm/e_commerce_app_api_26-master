import 'package:ecommerce_app_api_26/features/home/data/models/prduct_model.dart';
import 'package:ecommerce_app_api_26/features/home/data/product_api/products_api.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_app_api_26/features/home/presentation/widgets/product_card.dart';

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

    return Scaffold(
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
                Text('Welcome,', style: TextStyle(color: Colors.grey.shade600, fontSize: 14)),
                const Text('Our Shop', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22, color: Colors.black)),
              ],
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: IconButton(
                icon: const Icon(Icons.notifications_none, color: Colors.blue),
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
                    )
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
            FutureBuilder(future: ProductsApi().getAllProducts(), builder:  (context, snapshot) {
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
              return  Padding(
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
                    );
                  },
                ),
              );


            },),


            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}



// SingleChildScrollView(
// scrollDirection: Axis.horizontal,
// padding: const EdgeInsets.symmetric(horizontal: 16),
// child: Row(
// children: ['All', 'Shoes', 'Shirts', 'Tech', 'Home'].map((cat) {
// bool isAll = cat == 'All';
// return Container(
// margin: const EdgeInsets.only(right: 12),
// padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
// decoration: BoxDecoration(
// color: isAll ? Colors.blue : Colors.white,
// borderRadius: BorderRadius.circular(12),
// boxShadow: [
// if (!isAll)
// BoxShadow(
// color: Colors.black.withOpacity(0.05),
// blurRadius: 5,
// )
// ],
// ),
// child: Text(
// cat,
// style: TextStyle(
// color: isAll ? Colors.white : Colors.grey.shade700,
// fontWeight: FontWeight.bold,
// ),
// ),
// );
// }).toList(),
// ),
// )