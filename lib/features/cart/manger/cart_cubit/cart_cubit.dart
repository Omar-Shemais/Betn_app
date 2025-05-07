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
      emit(CartLoading());
      await repo.deleteCartItem(cartId: cartId);
      emit(CartSuccess(message: "تم حذف المنتج من السلة"));
      await getCartItems();
    } catch (e) {
      emit(CartError(error: e.toString()));
    }
  }

  Future<void> updateCartItemQuantity(int cartId, int quantity) async {
    try {
      emit(CartLoading());
      await repo.updateCartQuantity(cartId: cartId, quantity: quantity);

      emit(CartSuccess(message: "تم تحديث الكمية والسعر الإجمالي بنجاح"));
      getCartItems();
    } catch (e) {
      emit(CartError(error: e.toString()));
    }
  }
}
