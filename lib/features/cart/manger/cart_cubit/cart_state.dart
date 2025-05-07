part of 'cart_cubit.dart';

abstract class CartState {}

class CartInitial extends CartState {}

class CartLoading extends CartState {}

class CartSuccess extends CartState {
  final String message;
  CartSuccess({required this.message});
}

class CartSuccessWithItems extends CartState {
  final List<CartItem> items;
  CartSuccessWithItems({required this.items});
}

class CartError extends CartState {
  final String error;
  CartError({required this.error});
}
