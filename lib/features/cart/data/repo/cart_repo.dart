import 'package:furnitrue_app/core/utils/caching_utils/caching_utils.dart';
import 'package:furnitrue_app/core/utils/network_utils/network_utils.dart';

class CartRepo {
  Future<void> addToCart({
    required int userId,
    required int productId,
    required int quantity,
  }) async {
    final response = await NetworkUtils.post(
      'cart/cart.php',
      data: {'user_id': userId, 'product_id': productId, 'quantity': quantity},
    );
    if (response.data['status'] != 'success') {
      throw Exception(response.data['message']);
    }
  }

  Future<List<dynamic>> getCartItems() async {
    final userId = CachingUtils.userID;
    final response = await NetworkUtils.get(
      'cart/cart.php',
      headers: {'user_id': userId},
    );

    if (response.data['status'] != 'success') {
      throw Exception(response.data['message']);
    }

    return response.data['cart'];
  }

  Future<void> deleteCartItem({required int cartId}) async {
    final userId = CachingUtils.userID;
    final response = await NetworkUtils.delete(
      'cart/cart.php',
      headers: {'user_id': userId},
      data: {'cart_id': cartId},
    );
    if (response.data['status'] != 'success') {
      throw Exception(response.data['message']);
    }
  }

  Future<void> updateCartQuantity({
    required int cartId,
    required int quantity,
  }) async {
    final userId = CachingUtils.userID;

    final response = await NetworkUtils.put(
      'cart/cart.php',
      headers: {'user_id': userId},
      data: {'cart_id': cartId, 'quantity': quantity},
    );

    if (response.data['status'] != 'success') {
      throw Exception(response.data['message']);
    }
  }
}
