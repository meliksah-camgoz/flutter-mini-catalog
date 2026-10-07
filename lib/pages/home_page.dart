import 'package:flutter/material.dart';

import '../models/product.dart';
import '../services/api_service.dart';
import '../services/cart_service.dart';
import '../widgets/product_card.dart';
import 'cart_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ApiService _apiService = ApiService();

  final TextEditingController _searchController = TextEditingController();

  late Future<List<Product>> _productsFuture;

  List<Product> _allProducts = [];
  List<Product> _filteredProducts = [];

  @override
  void initState() {
    super.initState();

    _productsFuture = _apiService.fetchProducts();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _searchProducts(String query) {
    final searchText = query.trim().toLowerCase();

    setState(() {
      if (searchText.isEmpty) {
        _filteredProducts = _allProducts;
      } else {
        _filteredProducts = _allProducts.where((product) {
          final name = product.name.toLowerCase();
          final tagline = product.tagline.toLowerCase();
          final description = product.description.toLowerCase();

          return name.contains(searchText) ||
              tagline.contains(searchText) ||
              description.contains(searchText);
        }).toList();
      }
    });
  }

  void _openProductDetail(Product product) {
    Navigator.pushNamed(context, '/product-detail', arguments: product);
  }

  void _openCart() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const CartPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8FA),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF8F8FA),
        elevation: 0,
        title: const Text(
          'Discover',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        ),
        actions: [
          AnimatedBuilder(
            animation: CartService.instance,
            builder: (context, child) {
              return Stack(
                children: [
                  IconButton(
                    onPressed: _openCart,
                    icon: const Icon(Icons.shopping_bag_outlined),
                  ),
                  if (CartService.instance.itemCount > 0)
                    Positioned(
                      right: 6,
                      top: 6,
                      child: Container(
                        padding: const EdgeInsets.all(5),
                        decoration: const BoxDecoration(
                          color: Colors.deepPurple,
                          shape: BoxShape.circle,
                        ),
                        child: Text(
                          '${CartService.instance.itemCount}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: FutureBuilder<List<Product>>(
        future: _productsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Text(
                  'Ürünler yüklenirken bir hata oluştu:\n\n${snapshot.error}',
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Henüz ürün bulunamadı.'));
          }

          if (_allProducts.isEmpty) {
            _allProducts = snapshot.data!;
            _filteredProducts = _allProducts;
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(16, 4, 16, 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Created by: Melikşah Camgöz',
                  style: TextStyle(fontSize: 15, color: Colors.grey),
                ),

                const SizedBox(height: 18),

                // Arama alanı
                TextField(
                  controller: _searchController,
                  onChanged: _searchProducts,
                  decoration: InputDecoration(
                    hintText: 'Search products...',
                    hintStyle: TextStyle(color: Colors.grey.shade500),
                    prefixIcon: const Icon(Icons.search, color: Colors.grey),
                    suffixIcon: _searchController.text.isNotEmpty
                        ? IconButton(
                            onPressed: () {
                              _searchController.clear();
                              _searchProducts('');
                            },
                            icon: const Icon(Icons.clear),
                          )
                        : null,
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.symmetric(vertical: 16),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // Banner
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network(
                    'https://wantapi.com/assets/banner.png',
                    width: double.infinity,
                    height: 155,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        width: double.infinity,
                        height: 155,
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Color(0xFF6C63FF), Color(0xFF8B80FF)],
                          ),
                        ),
                        child: const Center(
                          child: Text(
                            'Special Offer',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),

                const SizedBox(height: 30),

                // Ürün başlığı
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'Featured Products',
                      style: TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.deepPurple.withValues(alpha: 0.08),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        '${_filteredProducts.length} products',
                        style: const TextStyle(
                          color: Colors.deepPurple,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                // Arama sonucu yoksa
                if (_filteredProducts.isEmpty)
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      vertical: 50,
                      horizontal: 20,
                    ),
                    child: Column(
                      children: [
                        Icon(
                          Icons.search_off,
                          size: 60,
                          color: Colors.grey.shade400,
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'No products found',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Try searching for another product.',
                          style: TextStyle(color: Colors.grey.shade600),
                        ),
                      ],
                    ),
                  )
                else
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _filteredProducts.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 14,
                          childAspectRatio: 0.68,
                        ),
                    itemBuilder: (context, index) {
                      final product = _filteredProducts[index];

                      return ProductCard(
                        product: product,
                        onTap: () => _openProductDetail(product),
                      );
                    },
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
