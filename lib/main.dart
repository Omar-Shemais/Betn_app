import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:furnitrue_app/core/utils/app_colors/app_colors.dart';
import 'package:furnitrue_app/core/utils/caching_utils/caching_utils.dart';
import 'package:furnitrue_app/core/utils/network_utils/network_utils.dart';
import 'package:furnitrue_app/core/utils/route_utils/route_utils.dart';
import 'package:furnitrue_app/features/cart/data/repo/cart_repo.dart';
import 'package:furnitrue_app/features/cart/manger/cart_cubit/cart_cubit.dart';
import 'package:furnitrue_app/features/favorite/manger/cubit/favorite_cubit.dart';
import 'package:furnitrue_app/features/splash/presentation/view/splash_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ScreenUtil.ensureScreenSize();
  await NetworkUtils.init();
  await CachingUtils.init();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => FavoriteCubit()..loadFavorites()),
        BlocProvider(
          create: (context) => CartCubit(CartRepo())..getCartItems(),
        ),
      ],
      child: const BetnApp(),
    ),
  );
}

class BetnApp extends StatelessWidget {
  const BetnApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: RouteUtils.navigatorKey,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.white,
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: AppColors.primaryColor,
          selectionColor: AppColors.lightTextColor,
          selectionHandleColor: AppColors.primaryColor,
        ),
        primaryColor: Color(0xff355B5E),
      ),
      builder: (context, child) {
        ScreenUtil.init(context, designSize: const Size(375, 812));
        return child!;
      },
      title: "betn",
      home: const SplashView(),
    );
  }
}
