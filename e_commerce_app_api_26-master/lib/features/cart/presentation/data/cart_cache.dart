import 'package:shared_preferences/shared_preferences.dart';

///local cart with shared_preferences

class CartCache {
  ///ال key الي بيتخزن فيها الid
  static const String cartKey = "cart_ids";
  // إضافة منتج للكارت
  static Future<void> addToCart(String id) async {
    ///بيفتحلنا طريق اننا نقدر نستخدم المساحه الي موفرهلنا الباكدج
    final prefs = await SharedPreferences.getInstance();

    List<String> cart = prefs.getStringList(cartKey) ?? [];

    /// هيشوف ال id الي جاي موجود في ال cart ولا لاء عشان يمنع تكرار المنتج
    if (!cart.contains(id)) {
      cart.add(id);
    }
    await prefs.setStringList(cartKey, cart);
  }

  // حذف منتج
  static Future<void> removeFromCart(String id) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> cart = prefs.getStringList(cartKey) ?? [];
    cart.remove(id);
    await prefs.setStringList(cartKey, cart);
  }

  // جلب كل الكارت
  static Future<List<String>> getCart() async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.getStringList(cartKey) ?? [];
  }

  // مسح الكارت
  static Future<void> clearCart() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(cartKey);
  }
}
