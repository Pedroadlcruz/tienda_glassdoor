import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../products/data/models/product.dart';
import '../../../data/models/cart_item.dart';
import '../../../domain/usecases/cart_usecases.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final CartUseCases _cartUseCases;
  StreamSubscription<List<CartItem>>? _cartSubscription;

  CartBloc(this._cartUseCases) : super(CartInitial()) {
    on<LoadCart>(_onLoadCart);
    on<AddToCart>(_onAddToCart);
    on<RemoveFromCart>(_onRemoveFromCart);
    on<UpdateItemQuantity>(_onUpdateItemQuantity);
    on<ClearCart>(_onClearCart);
    on<_LoadCartEmpty>(_onLoadCartEmpty);
    on<_LoadCartSuccess>(_onLoadCartSuccess);
  }

  Future<void> _onLoadCart(LoadCart event, Emitter<CartState> emit) async {
    print('[DEBUG] Loading cart for user: ${event.userId}');
    emit(CartLoading());

    try {
      if (event.userId.isEmpty) {
        add(const _LoadCartEmpty(0));
      }
      // Listen to cart changes
      _cartSubscription?.cancel();
      _cartSubscription = _cartUseCases.getCartStream(event.userId).listen((
        items,
      ) {
        print('[DEBUG] Cart stream received ${items.length} items');
        final totalItems = _cartUseCases.calculateTotalItems(items);
        if (items.isEmpty) {
          print('[DEBUG] Cart is empty');
          add(_LoadCartEmpty(totalItems));
        } else {
          final total = _cartUseCases.calculateTotal(items);
          print(
            '[DEBUG] Cart loaded: $totalItems items, total: \$${total.toStringAsFixed(2)}',
          );
          add(_LoadCartSuccess(items, total, totalItems));
        }
      });
    } catch (e) {
      print('[ERROR] Error loading cart: $e');
      emit(CartError(e.toString()));
    }
  }

  Future<void> _onAddToCart(AddToCart event, Emitter<CartState> emit) async {
    try {
      await _cartUseCases.addToCart(
        event.userId,
        event.product,
        quantity: event.quantity,
      );
    } catch (e) {
      emit(CartError(e.toString()));
    }
  }

  Future<void> _onRemoveFromCart(
    RemoveFromCart event,
    Emitter<CartState> emit,
  ) async {
    try {
      await _cartUseCases.removeFromCart(event.userId, event.itemId);
    } catch (e) {
      emit(CartError(e.toString()));
    }
  }

  Future<void> _onUpdateItemQuantity(
    UpdateItemQuantity event,
    Emitter<CartState> emit,
  ) async {
    try {
      await _cartUseCases.updateItemQuantity(
        event.userId,
        event.itemId,
        event.quantity,
      );
    } catch (e) {
      emit(CartError(e.toString()));
    }
  }

  Future<void> _onClearCart(ClearCart event, Emitter<CartState> emit) async {
    try {
      await _cartUseCases.clearCart(event.userId);
    } catch (e) {
      emit(CartError(e.toString()));
    }
  }

  void _onLoadCartEmpty(_LoadCartEmpty event, Emitter<CartState> emit) {
    emit(CartEmpty(totalItems: event.totalItems));
  }

  void _onLoadCartSuccess(_LoadCartSuccess event, Emitter<CartState> emit) {
    emit(
      CartLoaded(
        items: event.items,
        total: event.total,
        totalItems: event.totalItems,
      ),
    );
  }

  @override
  Future<void> close() {
    _cartSubscription?.cancel();
    return super.close();
  }
}

//! Private events for internal use
class _LoadCartEmpty extends CartEvent {
  final int totalItems;

  const _LoadCartEmpty(this.totalItems);

  @override
  List<Object?> get props => [totalItems];
}

class _LoadCartSuccess extends CartEvent {
  final List<CartItem> items;
  final double total;
  final int totalItems;

  const _LoadCartSuccess(this.items, this.total, this.totalItems);

  @override
  List<Object?> get props => [items, total, totalItems];
}
