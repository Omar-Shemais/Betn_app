class CartResponseModel {
  final String status;
  final List<CartItem> cart;

  CartResponseModel({required this.status, required this.cart});

  factory CartResponseModel.fromJson(Map<String, dynamic> json) {
    return CartResponseModel(
      status: json['status'],
      cart: List<CartItem>.from(json['cart'].map((x) => CartItem.fromJson(x))),
    );
  }
}

class CartItem {
  final int id;
  final int quantity;
  final String name;
  final String price;

  CartItem({
    required this.id,
    required this.quantity,
    required this.name,
    required this.price,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      id: json['id'],
      quantity: json['quantity'],
      name: json['name'],
      price: json['price'],
    );
  }
}
