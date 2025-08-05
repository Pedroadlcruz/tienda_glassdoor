import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/config/theme/text_styles.dart';
import '../../../auth/presentation/blocs/auth/auth_bloc.dart';
import '../../../cart/presentation/blocs/cart/cart_bloc.dart';
import '../../data/models/product.dart';
import '../blocs/product_detail/product_detail_bloc.dart';

class ProductDetailPage extends StatelessWidget {
  const ProductDetailPage({super.key});

  void _addToCart(Product product, BuildContext context) {
    final authState = context.read<AuthBloc>().state;
    final quantity = context.read<ProductDetailBloc>().quantity;
    if (authState is AuthAuthenticated) {
      context.read<CartBloc>().add(
        AddToCart(
          userId: authState.user.id,
          product: product,
          quantity: quantity,
        ),
      );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${product.name} agregado al carrito'),
          backgroundColor: Colors.green,
        ),
      );
    } else {
      // Show dialog to prompt user to login
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Iniciar Sesión Requerido'),
          content: const Text(
            'Debes iniciar sesión para agregar productos al carrito.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                context.go('/login');
              },
              child: const Text('Iniciar Sesión'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final quantity = context.select(
      (ProductDetailBloc bloc) => bloc.state is ProductDetailLoaded
          ? (bloc.state as ProductDetailLoaded).quantity
          : 1,
    );
    return Scaffold(
      body: BlocBuilder<ProductDetailBloc, ProductDetailState>(
        builder: (context, state) {
          if (state is ProductDetailLoading) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }

          if (state is ProductDetailError) {
            return Scaffold(
              appBar: AppBar(title: const Text('Detalle del Producto')),
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.error_outline,
                      size: 64,
                      color: Colors.grey[400],
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Error al cargar el producto',
                      style: TextStyles.errorMessage,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      state.message,
                      style: TextStyles.smallErrorMessage,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            );
          }

          if (state is ProductDetailLoaded) {
            final product = state.product;
            return Scaffold(
              body: CustomScrollView(
                slivers: [
                  // App Bar with Image
                  SliverAppBar(
                    expandedHeight: 300,
                    pinned: true,
                    flexibleSpace: FlexibleSpaceBar(
                      background: CachedNetworkImage(
                        imageUrl: product.imageUrl,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Container(
                          color: Colors.grey[300],
                          child: const Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                        errorWidget: (context, url, error) => Container(
                          color: Colors.grey[300],
                          child: const Icon(
                            Icons.error,
                            color: Colors.grey,
                            size: 64,
                          ),
                        ),
                      ),
                    ),
                    leading: IconButton(
                      onPressed: () => context.pop(),
                      icon: const Icon(Icons.arrow_back),
                    ),
                  ),

                  // Product Details
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Product Name
                          Text(
                            product.name,
                            style: TextStyles.productName,
                          ),
                          const SizedBox(height: 8),

                          // Price
                          Text(
                            '\$${product.price.toStringAsFixed(2)}',
                            style: TextStyles.productPrice.copyWith(
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                          const SizedBox(height: 16),

                          // Rating
                          Row(
                            children: [
                              Icon(
                                Icons.star,
                                color: Colors.amber[600],
                                size: 20,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                product.rating.toString(),
                                style: TextStyles.boldText,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                '(${product.reviewCount} reseñas)',
                                style: TextStyles.smallGreyText,
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),

                          // Stock
                          Row(
                            children: [
                              Icon(
                                Icons.inventory,
                                color: product.stock > 0
                                    ? Colors.green
                                    : Colors.red,
                                size: 20,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                product.stock > 0
                                    ? 'En stock (${product.stock} disponibles)'
                                    : 'Sin stock',
                                style: TextStyles.smallText.copyWith(
                                  color: product.stock > 0
                                      ? Colors.green
                                      : Colors.red,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 24),

                          // Description
                          Text(
                            'Descripción',
                            style: TextStyles.sectionTitle,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            product.description,
                            style: TextStyles.productDescription,
                          ),
                          const SizedBox(height: 32),

                          // Quantity Selector
                          if (product.stock > 0) ...[
                            Text(
                              'Cantidad',
                              style: TextStyles.boldText,
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                IconButton(
                                  onPressed: quantity > 1
                                      ? () => context
                                            .read<ProductDetailBloc>()
                                            .add(
                                              UpdateProductQuantity(
                                                quantity - 1,
                                              ),
                                            )
                                      : null,
                                  icon: const Icon(Icons.remove),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 8,
                                  ),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    '$quantity',
                                    style: TextStyles.boldText,
                                  ),
                                ),
                                IconButton(
                                  onPressed: quantity < product.stock
                                      ? () => context
                                            .read<ProductDetailBloc>()
                                            .add(
                                              UpdateProductQuantity(
                                                quantity + 1,
                                              ),
                                            )
                                      : null,
                                  icon: const Icon(Icons.add),
                                ),
                                const Spacer(),
                                Text(
                                  'Stock: ${product.stock}',
                                  style: TextStyles.smallGreyText,
                                ),
                              ],
                            ),
                            const SizedBox(height: 32),
                          ],
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              bottomNavigationBar: product.stock > 0
                  ? Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.1),
                            blurRadius: 10,
                            offset: const Offset(0, -5),
                          ),
                        ],
                      ),
                      child: ElevatedButton(
                        onPressed: () => _addToCart(product, context),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                        child: Text(
                          'Agregar al Carrito - \$${(product.price * quantity).toStringAsFixed(2)}',
                          style: TextStyles.buttonText,
                        ),
                      ),
                    )
                  : null,
            );
          }

          return const Scaffold(
            body: Center(child: Text('Producto no encontrado')),
          );
        },
      ),
    );
  }
}
