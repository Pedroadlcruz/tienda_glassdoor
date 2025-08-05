part of 'cart_bloc.dart';

sealed class CartState extends Equatable {
  const CartState();

  @override
  List<Object?> get props => [];
}

final class CartInitial extends CartState {}

final class CartLoading extends CartState {}

final class CartLoaded extends CartState {
  final List<CartItem> items;
  final double total;
  final int totalItems;

  const CartLoaded({
    required this.items,
    required this.total,
    required this.totalItems,
  });

  @override
  List<Object?> get props => [items, total, totalItems];
}

final class CartEmpty extends CartState {
  final int totalItems;

  const CartEmpty({this.totalItems = 0});

  @override
  List<Object?> get props => [totalItems];
}

final class CartError extends CartState {
  final String message;

  const CartError(this.message);

  @override
  List<Object?> get props => [message];
}
