part of 'cart_bloc.dart';

sealed class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object?> get props => [];
}

final class LoadCart extends CartEvent {
  final String userId;

  const LoadCart(this.userId);

  @override
  List<Object?> get props => [userId];
}

final class AddToCart extends CartEvent {
  final String userId;
  final Product product;
  final int quantity;

  const AddToCart({
    required this.userId,
    required this.product,
    this.quantity = 1,
  });

  @override
  List<Object?> get props => [userId, product, quantity];
}

final class RemoveFromCart extends CartEvent {
  final String userId;
  final String itemId;

  const RemoveFromCart({required this.userId, required this.itemId});

  @override
  List<Object?> get props => [userId, itemId];
}

final class UpdateItemQuantity extends CartEvent {
  final String userId;
  final String itemId;
  final int quantity;

  const UpdateItemQuantity({
    required this.userId,
    required this.itemId,
    required this.quantity,
  });

  @override
  List<Object?> get props => [userId, itemId, quantity];
}

final class ClearCart extends CartEvent {
  final String userId;

  const ClearCart(this.userId);

  @override
  List<Object?> get props => [userId];
}
