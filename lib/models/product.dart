class Product {
  final int id;
  final String name;
  final String tagline;
  final String price;
  final String description;
  final String image;

  Product({
    required this.id,
    required this.name,
    required this.tagline,
    required this.price,
    required this.description,
    required this.image,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'] ?? '',
      tagline: json['tagline'] ?? '',
      price: json['price'] ?? '',
      description: json['description'] ?? '',
      image: json['image'] ?? '',
    );
  }
}
