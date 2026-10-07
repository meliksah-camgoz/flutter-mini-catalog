import 'dart:convert';
import 'dart:io';

import '../models/product.dart';

class ApiService {
  static const String baseUrl = 'https://wantapi.com/products.php';

  Future<List<Product>> fetchProducts() async {
    final uri = Uri.parse(baseUrl);

    final client = HttpClient();

    try {
      final request = await client.getUrl(uri);

      final response = await request.close();

      if (response.statusCode == 200) {
        final responseBody = await response.transform(utf8.decoder).join();

        final Map<String, dynamic> json = jsonDecode(responseBody);

        final List<dynamic> data = json['data'];

        return data
            .map((item) => Product.fromJson(item as Map<String, dynamic>))
            .toList();
      } else {
        throw Exception(
          'Ürünler alınamadı. '
          'Hata kodu: ${response.statusCode}',
        );
      }
    } finally {
      client.close();
    }
  }
}
