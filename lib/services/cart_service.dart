import 'package:flutter/foundation.dart';

import '../models/product.dart';

class CartService extends ChangeNotifier {
  CartService._();

  static final CartService instance = CartService._();

  final List<Product> _items = [];

  List<Product> get items => List.unmodifiable(_items);

  bool get isEmpty => _items.isEmpty;

  int get itemCount => _items.length;

  double get total {
    double result = 0;

    for (final product in _items) {
      final price = double.tryParse(
        product.price.replaceAll(RegExp(r'[^0-9.]'), ''),
      );

      if (price != null) {
        result += price;
      }
    }

    return result;
  }

  void addProduct(Product product) {
    _items.add(product);
    notifyListeners();
  }

  void removeProduct(Product product) {
    _items.remove(product);
    notifyListeners();
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
  }
}
