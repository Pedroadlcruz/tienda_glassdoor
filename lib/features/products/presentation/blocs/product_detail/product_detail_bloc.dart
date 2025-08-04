import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/product.dart';
import '../../../domain/usecases/products_usecases.dart';

part 'product_detail_event.dart';
part 'product_detail_state.dart';

class ProductDetailBloc extends Bloc<ProductDetailEvent, ProductDetailState> {
  final ProductsUseCases _productsUseCases;
  ProductDetailBloc(this._productsUseCases) : super(ProductDetailInitial()) {
    on<LoadProductDetail>(_onLoadProductDetail);
    on<UpdateProductQuantity>(_onUpdateProductQuantity);
  }

  Future<void> _onLoadProductDetail(
    LoadProductDetail event,
    Emitter<ProductDetailState> emit,
  ) async {
    emit(ProductDetailLoading());
    try {
      final product = await _productsUseCases.getProductById(event.productId);
      if (product == null) {
        emit(const ProductDetailError('Product not found'));
        return;
      }
      emit(ProductDetailLoaded(product, 1));
    } catch (e) {
      emit(ProductDetailError(e.toString()));
      return;
    }
  }

  FutureOr<void> _onUpdateProductQuantity(
    UpdateProductQuantity event,
    Emitter<ProductDetailState> emit,
  ) {
    if (state is ProductDetailLoaded) {
      final currentState = state as ProductDetailLoaded;
      //Check the available stock
      if (event.quantity < 1 || event.quantity > currentState.product.stock) {
        emit(const ProductDetailError('Invalid quantity'));
      } else {
        // Update the quantity in the current state
        emit(ProductDetailLoaded(currentState.product, event.quantity));
      }
    }
  }
}
