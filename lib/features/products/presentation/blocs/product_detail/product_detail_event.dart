part of 'product_detail_bloc.dart';

sealed class ProductDetailEvent extends Equatable {
  const ProductDetailEvent();

  @override
  List<Object> get props => [];
}

final class LoadProductDetail extends ProductDetailEvent {
  final String productId;

  const LoadProductDetail(this.productId);

  @override
  List<Object> get props => [productId];
}

final class UpdateProductQuantity extends ProductDetailEvent {
  final int quantity;

  const UpdateProductQuantity(this.quantity);

  @override
  List<Object> get props => [quantity];
}
