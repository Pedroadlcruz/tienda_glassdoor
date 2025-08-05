import '../../data/models/cart_item.dart';

abstract class CartRepository {
  Future<List<CartItem>> getCartItems(String userId);

  Future<void> addToCart(String userId, CartItem item);

  Future<void> removeFromCart(String userId, String itemId);

  Future<void> updateItemQuantity(String userId, String itemId, int quantity);

  Future<void> clearCart(String userId);

  Stream<List<CartItem>> getCartStream(String userId);
}
