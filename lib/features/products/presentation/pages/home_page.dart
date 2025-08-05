import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/constants/strings.dart';
import '../../../auth/presentation/blocs/auth/auth_bloc.dart';
import '../../../cart/presentation/blocs/cart/cart_bloc.dart';
import '../../domain/enums/product_category.dart';
import '../blocs/products/products_bloc.dart';
import '../widgets/product_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onCategoryChanged(ProductCategory category) {
    context.read<ProductsBloc>().add(SelectCategory(category));
  }

  void _onSearchChanged(String query) {
    if (query.isNotEmpty) {
      // Get current category from state
      final currentState = context.read<ProductsBloc>().state;
      ProductCategory? currentCategory;
      
      if (currentState is ProductsLoaded) {
        currentCategory = currentState.selectedCategory;
      }
      
      context.read<ProductsBloc>().add(SearchProducts(query, category: currentCategory));
    } else {
      // Reset to current category when search is cleared
      final currentState = context.read<ProductsBloc>().state;
      if (currentState is ProductsLoaded) {
        context.read<ProductsBloc>().add(SelectCategory(currentState.selectedCategory));
      } else {
        context.read<ProductsBloc>().add(LoadProducts());
      }
    }
  }

  void _onSignOut() {
    context.read<AuthBloc>().add(SignOut());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(Strings.appTitle),
        actions: [
          BlocBuilder<AuthBloc, AuthState>(
            builder: (context, authState) {
              if (authState is AuthAuthenticated) {
                return BlocBuilder<CartBloc, CartState>(
                  builder: (context, cartState) {
                    int itemCount = 0;
                    if (cartState is CartLoaded) {
                      itemCount = cartState.totalItems;
                    } else if (cartState is CartEmpty) {
                      itemCount = cartState.totalItems;
                    }

                    return Stack(
                      children: [
                        IconButton(
                          onPressed: () =>
                              context.go('/home/cart/${authState.user.id}'),
                          icon: const Icon(Icons.shopping_cart),
                        ),
                        if (itemCount > 0)
                          Positioned(
                            right: 8,
                            top: 8,
                            child: Container(
                              padding: const EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              constraints: const BoxConstraints(
                                minWidth: 16,
                                minHeight: 16,
                              ),
                              child: Text(
                                '$itemCount',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                      ],
                    );
                  },
                );
              }
              return const SizedBox.shrink();
            },
          ),
          BlocBuilder<AuthBloc, AuthState>(
            builder: (context, authState) {
              if (authState is AuthAuthenticated) {
                return PopupMenuButton<String>(
                  onSelected: (value) {
                    if (value == 'profile') {
                      context.go('/home/profile');
                    } else if (value == 'logout') {
                      _onSignOut();
                    }
                  },
                  itemBuilder: (context) => [
                                            const PopupMenuItem(
                          value: 'profile',
                          child: Row(
                            children: [
                              Icon(Icons.person),
                              SizedBox(width: 8),
                              Text(Strings.profile),
                            ],
                          ),
                        ),
                        const PopupMenuItem(
                          value: 'logout',
                          child: Row(
                            children: [
                              Icon(Icons.logout),
                              SizedBox(width: 8),
                              Text(Strings.logout),
                            ],
                          ),
                        ),
                  ],
                );
              } else {
                return PopupMenuButton<String>(
                  onSelected: (value) {
                    if (value == 'login') {
                      context.go('/login');
                    } else if (value == 'register') {
                      context.go('/register');
                    }
                  },
                  itemBuilder: (context) => [
                    const PopupMenuItem(
                      value: 'login',
                      child: Row(
                        children: [
                          Icon(Icons.login),
                          SizedBox(width: 8),
                          Text(Strings.login),
                        ],
                      ),
                    ),
                    const PopupMenuItem(
                      value: 'register',
                      child: Row(
                        children: [
                          Icon(Icons.person_add),
                          SizedBox(width: 8),
                          Text(Strings.register),
                        ],
                      ),
                    ),
                  ],
                );
              }
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: Strings.searchProducts,
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: Colors.grey[100],
              ),
              onChanged: _onSearchChanged,
            ),
          ),

          // Category Filter
          BlocBuilder<ProductsBloc, ProductsState>(
            builder: (context, state) {
              final selectedCategory = state is ProductsLoaded 
                  ? state.selectedCategory 
                  : ProductCategory.all;

              return SizedBox(
                height: 50,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: ProductCategory.availableCategories.length,
                  itemBuilder: (context, index) {
                    final category = ProductCategory.availableCategories[index];
                    final isSelected = category == selectedCategory;

                    return Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: FilterChip(
                        label: Text(category.displayName),
                        selected: isSelected,
                        onSelected: (selected) {
                          if (selected) {
                            _onCategoryChanged(category);
                          }
                        },
                        selectedColor: Theme.of(context).colorScheme.primary,
                        checkmarkColor: Colors.white,
                      ),
                    );
                  },
                ),
              );
            },
          ),

          const SizedBox(height: 16),

          // Products Grid
          Expanded(
            child: BlocBuilder<ProductsBloc, ProductsState>(
              builder: (context, state) {
                if (state is ProductsLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (state is ProductsError) {
                  return Center(
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
                          Strings.errorLoadingProducts,
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            color: Colors.grey[600],
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          state.message,
                          style: GoogleFonts.poppins(color: Colors.grey[500]),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  );
                }

                if (state is ProductsLoaded) {
                  if (state.products.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.search_off,
                            size: 64,
                            color: Colors.grey[400],
                          ),
                          const SizedBox(height: 16),
                          Text(
                            Strings.noProductsFound,
                            style: GoogleFonts.poppins(
                              fontSize: 18,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    );
                  }

                  return GridView.builder(
                    padding: const EdgeInsets.all(16),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.8,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                        ),
                    itemCount: state.products.length,
                    itemBuilder: (context, index) {
                      final product = state.products[index];
                      return ProductCard(product: product);
                    },
                  );
                }

                return const SizedBox.shrink();
              },
            ),
          ),
        ],
      ),
    );
  }
}
