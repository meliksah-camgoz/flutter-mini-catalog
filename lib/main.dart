import 'package:flutter/material.dart';

import 'models/product.dart';
import 'pages/home_page.dart';
import 'pages/product_detail_page.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(const MiniCatalogApp());
}

class MiniCatalogApp extends StatelessWidget {
  const MiniCatalogApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mini Catalog',
      theme: AppTheme.lightTheme,
      home: const HomePage(),
      onGenerateRoute: (settings) {
        if (settings.name == '/product-detail') {
          final product = settings.arguments as Product;

          return MaterialPageRoute(
            builder: (context) {
              return ProductDetailPage(product: product);
            },
          );
        }

        return null;
      },
    );
  }
}
