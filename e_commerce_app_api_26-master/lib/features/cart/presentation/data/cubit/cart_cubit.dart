import 'package:ecommerce_app_api_26/features/cart/presentation/data/cart_cache.dart';
import 'package:ecommerce_app_api_26/features/cart/presentation/data/cubit/cart_state.dart';
import 'package:ecommerce_app_api_26/features/home/data/product_api/products_api.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitial());

  Future<void> getCart() async {
    emit(CartLoading());
    try {
      final ids = await CartCache.getCart();
      final allProducts = await ProductsApi().getAllProducts();
      final cartItems = allProducts
          .where((product) => ids.contains(product.id.toString()))
          .map(
            (product) => {
              'id': product.id,
              'title': product.title,
              'price': product.price,
              'image': product.images?[0],
              'quantity': 1,
            },
          )
          .toList();
      emit(CartSuccess(cartItems));
    } catch (e) {
      emit(CartError(e.toString()));
    }
  }

  Future<void> addToCart(String id) async {
    await CartCache.addToCart(id);
    getCart();
  }

  Future<void> removeFromCart(String id) async {
    await CartCache.removeFromCart(id);
  }

  Future<void> clearCart() async {
    await CartCache.clearCart();
    getCart();
  }

  Future<void> increaseQty(int index) async {
    if (state is CartSuccess) {
      final cartItems = List<Map<String, dynamic>>.from(
        (state as CartSuccess).cartItems,
      );
      cartItems[index]['quantity']++;
      emit(CartSuccess(cartItems));
    }
  }

  Future<void> decreaseQty(int index) async {
    if (state is CartSuccess) {
      final cartItems = List<Map<String, dynamic>>.from(
        (state as CartSuccess).cartItems,
      );
      if (cartItems[index]['quantity'] > 1) {
        cartItems[index]['quantity']--;
      }
      emit(CartSuccess(cartItems));
    }
  }

  double getTotal() {
    if (state is CartSuccess) {
      final cartItems = (state as CartSuccess).cartItems;

      double total = 0;
      for (var item in cartItems) {
        total += item['price'] * item['quantity'];
      }
      return total;
    }
    return 0;
  }
}
