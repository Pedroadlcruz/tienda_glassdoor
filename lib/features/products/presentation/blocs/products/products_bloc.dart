import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/product.dart';
import '../../../domain/enums/product_category.dart';
import '../../../domain/usecases/products_usecases.dart';

part 'products_event.dart';
part 'products_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  final ProductsUseCases _productsUseCases;

  ProductsBloc(this._productsUseCases) : super(ProductsInitial()) {
    on<LoadProducts>(_onLoadProducts);
    on<LoadProductsByCategory>(_onLoadProductsByCategory);
    on<SearchProducts>(_onSearchProducts);
    on<SelectCategory>(_onSelectCategory);
  }

  Future<void> _onLoadProducts(
    LoadProducts event,
    Emitter<ProductsState> emit,
  ) async {
    emit(const ProductsLoading());

    try {
      final products = await _productsUseCases.getAllProducts();
      emit(ProductsLoaded(
        products: products,
        selectedCategory: ProductCategory.all,
      ));
    } catch (e) {
      emit(ProductsError(e.toString()));
    }
  }

  Future<void> _onLoadProductsByCategory(
    LoadProductsByCategory event,
    Emitter<ProductsState> emit,
  ) async {
    emit(ProductsLoading(selectedCategory: event.category));

    try {
      final products = await _productsUseCases.getProductsByCategory(
        event.category.displayName,
      );
      emit(ProductsLoaded(
        products: products,
        selectedCategory: event.category,
      ));
    } catch (e) {
      emit(ProductsError(e.toString(), selectedCategory: event.category));
    }
  }

  Future<void> _onSearchProducts(
    SearchProducts event,
    Emitter<ProductsState> emit,
  ) async {
    emit(ProductsLoading(selectedCategory: event.category));

    try {
      final products = await _productsUseCases.searchProducts(event.query);
      emit(ProductsLoaded(
        products: products,
        selectedCategory: event.category ?? ProductCategory.all,
        searchQuery: event.query,
      ));
    } catch (e) {
      emit(ProductsError(e.toString(), selectedCategory: event.category));
    }
  }

  Future<void> _onSelectCategory(
    SelectCategory event,
    Emitter<ProductsState> emit,
  ) async {
    if (event.category == ProductCategory.all) {
      add(LoadProducts());
    } else {
      add(LoadProductsByCategory(event.category));
    }
  }
}
