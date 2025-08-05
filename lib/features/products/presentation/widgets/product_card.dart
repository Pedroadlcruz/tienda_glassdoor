import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../auth/presentation/blocs/auth/auth_bloc.dart';
import '../../../cart/presentation/blocs/cart/cart_bloc.dart';
import '../../data/models/product.dart';

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({super.key, required this.product});

  void _addToCart(BuildContext context) {
    final authState = context.read<AuthBloc>().state;
    if (authState is AuthAuthenticated) {
      final userId = authState.user.id;
      context.read<CartBloc>().add(
        AddToCart(userId: userId, product: product, quantity: 1),
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
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: () => context.go('/home/product/${product.id}'),
        borderRadius: BorderRadius.circular(12),
        child: Stack(
          children: [
            SizedBox(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Product Image
                  Expanded(
                    flex: 2,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(12),
                      ),
                      child: CachedNetworkImage(
                        imageUrl: product.imageUrl,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        placeholder: (context, url) => Container(
                          color: Colors.grey[300],
                          child: const Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                        errorWidget: (context, url, error) => Container(
                          color: Colors.grey[300],
                          child: const Icon(Icons.error, color: Colors.grey),
                        ),
                      ),
                    ),
                  ),

                  // Product Info
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Product Name
                          Text(
                            product.name,
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              height: 1.3,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 8),

                          // Price
                          Text(
                            '\$${product.price.toStringAsFixed(2)}',
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                          const SizedBox(height: 8),

                          // Rating
                          Row(
                            children: [
                              Icon(
                                Icons.star,
                                size: 16,
                                color: Colors.amber[600],
                              ),
                              const SizedBox(width: 4),
                              Text(
                                product.rating.toString(),
                                style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey[700],
                                ),
                              ),
                              const SizedBox(width: 4),
                              Text(
                                '(${product.reviewCount})',
                                style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Add to Cart Button - Positioned on top right
            Positioned(
              bottom: 12,
              right: 12,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.yellowAccent.withOpacity(0.5),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: IconButton(
                  onPressed: () => _addToCart(context),
                  icon: const Icon(
                    Icons.add_shopping_cart,
                    color: Colors.white,
                    size: 18,
                  ),
                  padding: const EdgeInsets.all(10),
                  constraints: const BoxConstraints(
                    minWidth: 30,
                    minHeight: 30,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
