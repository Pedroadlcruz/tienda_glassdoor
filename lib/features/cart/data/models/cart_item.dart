import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../products/data/models/product.dart';

part 'cart_item.g.dart';

@JsonSerializable()
class CartItem extends Equatable {
  final String id;
  final Product product;
  final int quantity;

  const CartItem({
    required this.id,
    required this.product,
    required this.quantity,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) =>
      _$CartItemFromJson(json);

  Map<String, dynamic> toJson() => _$CartItemToJson(this);

  double get totalPrice => product.price * quantity;

  CartItem copyWith({String? id, Product? product, int? quantity}) {
    return CartItem(
      id: id ?? this.id,
      product: product ?? this.product,
      quantity: quantity ?? this.quantity,
    );
  }

  @override
  List<Object?> get props => [id, product, quantity];
  Map<String, dynamic> toMap() {
    return {'id': id, 'product': product.toJson(), 'quantity': quantity};
  }

  @override
  String toString() {
    return 'CartItem(id: $id, product: ${product.name}, quantity: $quantity)';
  }
}
