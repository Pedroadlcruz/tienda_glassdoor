import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

import '../../domain/repositories/cart_repository.dart';
import '../models/cart_item.dart';

class CartRepositoryImpl implements CartRepository {
  final FirebaseFirestore _firestore;
  // ignore: unused_field
  final Uuid _uuid;

  CartRepositoryImpl({FirebaseFirestore? firestore, Uuid? uuid})
    : _firestore = firestore ?? FirebaseFirestore.instance,
      _uuid = uuid ?? const Uuid();

  @override
  Future<List<CartItem>> getCartItems(String userId) async {
    try {
      final snapshot = await _firestore
          .collection('users')
          .doc(userId)
          .collection('cart')
          .get();

      return snapshot.docs.map((doc) {
        final data = doc.data();
        data['id'] = doc.id; // Ensure the document ID is included
        return CartItem.fromJson(data);
      }).toList();
    } catch (e) {
      throw Exception(
        'Ha ocurrido un error al cargar los artículos del carrito',
      );
    }
  }

  /// Get cart item by product ID
  Future<CartItem?> getCartItemByProductId(
    String userId,
    String productId,
  ) async {
    try {
      if (userId.isEmpty) return null;
      final items = await getCartItems(userId);
      if (items.isEmpty) {
        return null; // No items in cart
      }
      try {
        return items.firstWhere(
          (item) => item.product.id == productId,
          // orElse: () => throw Exception('Product not found in cart'),
        );
      } catch (e) {
        return null; // Product not found
      }
    } catch (e) {
      return null;
    }
  }

  @override
  Future<void> addToCart(String userId, CartItem item) async {
    try {
      // Check if product already exists in cart
      final existingItem = await getCartItemByProductId(
        userId,
        item.product.id,
      );

      if (existingItem != null) {
        // Product exists, update quantity
        final newQuantity = existingItem.quantity + item.quantity;
        await _firestore
            .collection('users')
            .doc(userId)
            .collection('cart')
            .doc(existingItem.id)
            .update({'quantity': newQuantity});
      } else {
        // Product doesn't exist, add new item
        final cartData = item.toMap();

        await _firestore
            .collection('users')
            .doc(userId)
            .collection('cart')
            .doc(item.id)
            .set(cartData);
      }
    } catch (e) {
      throw Exception('Ha ocurrido un error al agregar el artículo al carrito');
    }
  }

  @override
  Future<void> removeFromCart(String userId, String itemId) async {
    try {
      await _firestore
          .collection('users')
          .doc(userId)
          .collection('cart')
          .doc(itemId)
          .delete();
    } catch (e) {
      throw Exception(
        'Ha ocurrido un error al eliminar el artículo del carrito',
      );
    }
  }

  @override
  Future<void> updateItemQuantity(
    String userId,
    String itemId,
    int quantity,
  ) async {
    if (userId.isEmpty) return;
    try {
      await _firestore
          .collection('users')
          .doc(userId)
          .collection('cart')
          .doc(itemId)
          .update({'quantity': quantity});
    } catch (e) {
      throw Exception(
        'Ha ocurrido un error al actualizar la cantidad del artículo: $e',
      );
    }
  }

  @override
  Future<void> clearCart(String userId) async {
    try {
      if (userId.isEmpty) return;
      final snapshot = await _firestore
          .collection('users')
          .doc(userId)
          .collection('cart')
          .get();

      final batch = _firestore.batch();
      for (final doc in snapshot.docs) {
        batch.delete(doc.reference);
      }
      await batch.commit();
    } catch (e) {
      throw Exception('Ha ocurrido un error al vaciar el carrito: $e');
    }
  }

  @override
  Stream<List<CartItem>> getCartStream(String userId) {
    if (userId.isEmpty) return Stream.value([]);
    return _firestore
        .collection('users')
        .doc(userId)
        .collection('cart')
        .snapshots()
        .map((snapshot) {
          final items = snapshot.docs.map((doc) {
            final data = doc.data();
            data['id'] = doc.id; // Ensure the document ID is included
            try {
              final cartItem = CartItem.fromJson(data);
              return cartItem;
            } catch (e) {
              rethrow;
            }
          }).toList();
          return items;
        });
  }
}
