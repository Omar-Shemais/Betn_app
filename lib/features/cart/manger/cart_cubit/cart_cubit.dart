import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furnitrue_app/features/cart/data/model/cart_model.dart';
import 'package:furnitrue_app/features/cart/data/repo/cart_repo.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  final CartRepo repo;
  CartCubit(this.repo) : super(CartInitial());

  Future<void> addToCart(int userId, int productId, int quantity) async {
    try {
      emit(CartLoading());
      await repo.addToCart(
        userId: userId,
        productId: productId,
        quantity: quantity,
      );
      await getCartItems();
      emit(CartSuccess(message: "تمت إضافة المنتج إلى السلة"));
    } catch (e) {
      emit(CartError(error: e.toString()));
    }
  }

  Future<void> getCartItems() async {
    try {
      emit(CartLoading());
      final data = await repo.getCartItems();
      final items = data.map((item) => CartItem.fromJson(item)).toList();
      emit(CartSuccessWithItems(items: items));
    } catch (e) {
      emit(CartError(error: e.toString()));
    }
  }

  Future<void> deleteCartItem(int cartId) async {
    try {
      await repo.deleteCartItem(cartId: cartId);

      // ✅ remove item locally without getCartItems()
      if (state is CartSuccessWithItems) {
        final currentItems = List<CartItem>.from(
          (state as CartSuccessWithItems).items,
        );
        currentItems.removeWhere((item) => item.id == cartId);
        emit(CartSuccessWithItems(items: currentItems));
      } else {
        emit(CartSuccess(message: "تم حذف المنتج من السلة"));
      }
    } catch (e) {
      emit(CartError(error: e.toString()));
    }
  }

  Future<void> updateCartItemQuantity(int cartId, int quantity) async {
    try {
      await repo.updateCartQuantity(cartId: cartId, quantity: quantity);

      if (state is CartSuccessWithItems) {
        final currentItems = List<CartItem>.from(
          (state as CartSuccessWithItems).items,
        );
        final index = currentItems.indexWhere((item) => item.id == cartId);
        if (index != -1) {
          final old = currentItems[index];
          currentItems[index] = CartItem(
            id: old.id,
            name: old.name,
            quantity: quantity,
            price: old.price,
          );
          emit(CartSuccessWithItems(items: currentItems));
        }
      }
    } catch (e) {
      emit(CartError(error: e.toString()));
    }
  }

  bool isInCart(String productName) {
    if (state is CartSuccessWithItems) {
      final items = (state as CartSuccessWithItems).items;
      return items.any((item) => item.name == productName);
    }
    return false;
  }

  int? getCartIdByProductName(String name) {
    if (state is CartSuccessWithItems) {
      final items = (state as CartSuccessWithItems).items;
      try {
        return items.firstWhere((item) => item.name == name).id;
      } catch (_) {
        return null;
      }
    }
    return null;
  }

  Future<void> clearCart() async {
    try {
      emit(CartLoading());
      await repo.deleteCartItem(
        cartId: 0 - 10000000,
      ); // Assuming 0 clears the cart
      emit(CartSuccess(message: "تم مسح السلة بنجاح"));
      await getCartItems();
    } catch (e) {
      emit(CartError(error: e.toString()));
    }
  }
}
