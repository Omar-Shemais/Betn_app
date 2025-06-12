import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furnitrue_app/features/cart/data/repo/cart_repo.dart';
import 'package:furnitrue_app/features/cart/data/repo/paymob_repo.dart';
import 'package:furnitrue_app/features/cart/manger/cart_cubit/cart_cubit.dart';
import 'package:furnitrue_app/features/cart/manger/payment_cubit/payment_cubit.dart';
import 'package:furnitrue_app/features/cart/presentation/view/widgets/cart_view_body.dart';
import 'package:furnitrue_app/features/favorite/manger/cubit/favorite_cubit.dart';

class CartView extends StatelessWidget {
  const CartView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => CartCubit(CartRepo())..getCartItems(),
          ),
          BlocProvider(create: (context) => PaymentCubit(PaymobRepo())),
          BlocProvider(create: (context) => FavoriteCubit()..loadFavorites()),
        ],
        child: const CartViewBody(),
      ),
    );
  }
}
