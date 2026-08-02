import 'package:shared_preferences/shared_preferences.dart';

///local cart with shared_preferences

class CartCache {
  static const String cartKey = "cart_ids";
  static Future<void> addToCart(String id) async {
    final prefs = await SharedPreferences.getInstance();

    List<String> cart = prefs.getStringList(cartKey) ?? [];

    if (!cart.contains(id)) {
      cart.add(id);
    }
    await prefs.setStringList(cartKey, cart);
  }

  static Future<void> removeFromCart(String id) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> cart = prefs.getStringList(cartKey) ?? [];
    cart.remove(id);
    await prefs.setStringList(cartKey, cart);
  }

  static Future<List<String>> getCart() async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.getStringList(cartKey) ?? [];
  }

  static Future<void> clearCart() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(cartKey);
  }
}
