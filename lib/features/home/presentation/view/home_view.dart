import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furnitrue_app/features/cart/data/repo/cart_repo.dart';
import 'package:furnitrue_app/features/cart/manger/cart_cubit/cart_cubit.dart';
import 'package:furnitrue_app/features/favorite/manger/cubit/favorite_cubit.dart';
import 'package:furnitrue_app/features/home/data/category_repo.dart';
import 'package:furnitrue_app/features/home/manger/Categories_cubit/cubit/category_cubit.dart';
import 'package:furnitrue_app/features/home/manger/product_cubit/cubit/product_cubit.dart';
import 'package:furnitrue_app/features/home/presentation/view/widgets/home_view_body.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => CategoriesCubit(HomeRepo())..getCategories(),
          ),
          BlocProvider(
            create: (context) => ProductCubit(ProductRepo())..getProducts(),
          ),
          BlocProvider(create: (_) => CartCubit(CartRepo())),
          BlocProvider(create: (_) => FavoriteCubit()..loadFavorites()),
        ],
        child: HomeViewBody(),
      ),
    );
  }
}
