import 'package:uuid/uuid.dart';

import '../../../products/data/models/product.dart';
import '../../data/models/cart_item.dart';
import '../repositories/cart_repository.dart';

class CartUseCases {
  final CartRepository _cartRepository;
  final Uuid _uuid;

  CartUseCases(this._cartRepository) : _uuid = const Uuid();

  Future<List<CartItem>> getCartItems(String userId) {
    return _cartRepository.getCartItems(userId);
  }

  Future<void> addToCart(String userId, Product product, {int quantity = 1}) {
    final cartItem = CartItem(
      id: _uuid.v4(),
      product: product,
      quantity: quantity,
    );
    return _cartRepository.addToCart(userId, cartItem);
  }

  Future<void> removeFromCart(String userId, String itemId) {
    return _cartRepository.removeFromCart(userId, itemId);
  }

  Future<void> updateItemQuantity(String userId, String itemId, int quantity) {
    if (quantity <= 0) {
      return removeFromCart(userId, itemId);
    }
    return _cartRepository.updateItemQuantity(userId, itemId, quantity);
  }

  Future<void> clearCart(String userId) {
    return _cartRepository.clearCart(userId);
  }

  Stream<List<CartItem>> getCartStream(String userId) {
    return _cartRepository.getCartStream(userId);
  }

  double calculateTotal(List<CartItem> items) {
    return items.fold(0.0, (total, item) => total + item.totalPrice);
  }

  int calculateTotalItems(List<CartItem> items) {
    return items.fold(0, (total, item) => total + item.quantity);
  }
}
