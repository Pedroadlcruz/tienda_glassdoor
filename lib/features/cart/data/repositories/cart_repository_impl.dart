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
      print('Error loading cart items: $e');
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
        print('[DEBUG] No items found in cart for user: $userId');
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
      print('Error getting cart item by product ID: $e');
      return null;
    }
  }

  @override
  Future<void> addToCart(String userId, CartItem item) async {
    try {
      print('[DEBUG] CartRepository - Adding item to cart for user: $userId');
      print(
        '[DEBUG] CartRepository - Item: ${item.product.name}, quantity: ${item.quantity}',
      );

      // Check if product already exists in cart
      final existingItem = await getCartItemByProductId(
        userId,
        item.product.id,
      );

      if (existingItem != null) {
        // Product exists, update quantity
        print(
          '[DEBUG] CartRepository - Product already exists, updating quantity',
        );
        final newQuantity = existingItem.quantity + item.quantity;
        await _firestore
            .collection('users')
            .doc(userId)
            .collection('cart')
            .doc(existingItem.id)
            .update({'quantity': newQuantity});
        print(
          '[DEBUG] CartRepository - Successfully updated quantity to: $newQuantity',
        );
      } else {
        // Product doesn't exist, add new item
        print(
          '[DEBUG] CartRepository - Product doesn\'t exist, adding new item',
        );
        final cartData = item.toMap();
        print('[DEBUG] CartRepository - Cart data to save: $cartData');

        await _firestore
            .collection('users')
            .doc(userId)
            .collection('cart')
            .doc(item.id)
            .set(cartData);
        print('[DEBUG] CartRepository - Successfully added new item to cart');
      }
    } catch (e) {
      print('[ERROR] CartRepository - Error adding item to cart: $e');
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
    print('[DEBUG] CartRepository - Starting cart stream for user: $userId');
    if (userId.isEmpty) return Stream.value([]);
    return _firestore
        .collection('users')
        .doc(userId)
        .collection('cart')
        .snapshots()
        .map((snapshot) {
          print(
            '[DEBUG] CartRepository - Received snapshot with ${snapshot.docs.length} documents',
          );
          final items = snapshot.docs.map((doc) {
            final data = doc.data();
            data['id'] = doc.id; // Ensure the document ID is included
            print('[DEBUG] CartRepository - Processing document: ${doc.id}');
            print('[DEBUG] CartRepository - Document data: $data');
            try {
              final cartItem = CartItem.fromJson(data);
              print(
                '[DEBUG] CartRepository - Successfully parsed cart item: ${cartItem.product.name}',
              );
              return cartItem;
            } catch (e) {
              print('[ERROR] CartRepository - Error parsing cart item: $e');
              print('[ERROR] CartRepository - Data: $data');
              rethrow;
            }
          }).toList();
          print(
            '[DEBUG] CartRepository - Returning ${items.length} cart items',
          );
          return items;
        });
  }
}
