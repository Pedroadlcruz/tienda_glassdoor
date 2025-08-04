import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/product.dart';
import '../../../domain/usecases/products_usecases.dart';

part 'products_event.dart';
part 'products_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  final ProductsUseCases _productsUseCases;

  ProductsBloc(this._productsUseCases) : super(ProductsInitial()) {
    on<LoadProducts>(_onLoadProducts);
    on<LoadProductsByCategory>(_onLoadProductsByCategory);
    on<SearchProducts>(_onSearchProducts);
  }

  Future<void> _onLoadProducts(
    LoadProducts event,
    Emitter<ProductsState> emit,
  ) async {
    emit(ProductsLoading());

    try {
      final products = await _productsUseCases.getAllProducts();
      emit(ProductsLoaded(products));
    } catch (e) {
      emit(ProductsError(e.toString()));
    }
  }

  Future<void> _onLoadProductsByCategory(
    LoadProductsByCategory event,
    Emitter<ProductsState> emit,
  ) async {
    emit(ProductsLoading());

    try {
      final products = await _productsUseCases.getProductsByCategory(
        event.category,
      );
      emit(ProductsLoaded(products));
    } catch (e) {
      emit(ProductsError(e.toString()));
    }
  }

  Future<void> _onSearchProducts(
    SearchProducts event,
    Emitter<ProductsState> emit,
  ) async {
    emit(ProductsLoading());

    try {
      final products = await _productsUseCases.searchProducts(event.query);
      emit(ProductsLoaded(products));
    } catch (e) {
      emit(ProductsError(e.toString()));
    }
  }
}
