class ProductResponseModel {
  final String status;
  final List<Product> products;

  ProductResponseModel({required this.status, required this.products});

  factory ProductResponseModel.fromJson(Map<String, dynamic> json) {
    return ProductResponseModel(
      status: json['status'],
      products: List<Product>.from(
        json['products'].map((x) => Product.fromJson(x)),
      ),
    );
  }
}

class Product {
  final int id;
  final String name;
  final String description;
  final String price;
  final String categoryName;
  final List<String> images;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.categoryName,
    required this.images,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      price: json['price'],
      categoryName: json['category_name'],
      images: List<String>.from(json['images']),
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'category_name': categoryName,
      'images': images,
    };
  }
}
