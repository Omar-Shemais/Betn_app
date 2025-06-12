import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:furnitrue_app/core/utils/app_colors/app_colors.dart';
import 'package:furnitrue_app/core/utils/caching_utils/caching_utils.dart';
import 'package:furnitrue_app/core/utils/route_utils/route_utils.dart';
import 'package:furnitrue_app/core/widgets/app_app_bar.dart';
import 'package:furnitrue_app/core/widgets/custom_button.dart';
import 'package:furnitrue_app/core/widgets/custom_plus_icon.dart';
import 'package:furnitrue_app/core/widgets/custom_text_field.dart';
import 'package:furnitrue_app/core/widgets/snack_bar.dart';
import 'package:furnitrue_app/features/cart/manger/cart_cubit/cart_cubit.dart';
import 'package:furnitrue_app/features/cart/presentation/view/widgets/my_cart_container.dart';
import 'package:furnitrue_app/features/favorite/presintation/view/widget/fav_item.dart';
import 'package:furnitrue_app/features/home/data/model/prouduct_response_model.dart';
import 'package:furnitrue_app/features/product_details/presentation/view/product_details_view.dart';
import 'package:furnitrue_app/features/search/presintation/view/search_view.dart';

class FavoriteViewBody extends StatefulWidget {
  const FavoriteViewBody({super.key});

  @override
  State<FavoriteViewBody> createState() => _FavoriteViewBodyState();
}

class _FavoriteViewBodyState extends State<FavoriteViewBody> {
  @override
  void initState() {
    super.initState();
    loadFavorites();
    context.read<CartCubit>().getCartItems();
  }

  Future<void> loadFavorites() async {
    final raw = await CachingUtils.getFavoriteItems();
    setState(() {
      favoriteProducts = raw.map((e) => Product.fromJson(e)).toList();
    });
  }

  List<Product> favoriteProducts = []; // TODO: Replace with real list

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Column(
        children: [
          SizedBox(height: 46.h),
          AppAppBar(title: 'Favorite'),
          SizedBox(height: 36.h),
          CustomTextField(
            readOnly: true,
            onTap: () => RouteUtils.push(SearchView()),
            hint: 'Search',
            prefixIcon: Icon(Icons.search, color: AppColors.lightTextColor),
            suffixIcon: Padding(
              padding: const EdgeInsets.all(14),
              child: SvgPicture.asset(
                'assets/icons/mic_icon.svg',
                width: 15.w,
                height: 15.h,
              ),
            ),
          ),
          SizedBox(height: 25.h),

          /// 🛒 Favorite product list
          Expanded(
            child: ListView.separated(
              itemCount: favoriteProducts.length,
              separatorBuilder: (_, __) => SizedBox(height: 16.h),
              itemBuilder: (context, index) {
                final product = favoriteProducts[index];
                return InkWell(
                  onTap:
                      () =>
                          RouteUtils.push(ProductDetailsView(product: product)),
                  child: FavoriteProductItem(
                    product: product,
                    onPlusTap: () {
                      final cartCubit = context.read<CartCubit>();
                      final userId = CachingUtils.userID;

                      if (cartCubit.state is! CartSuccessWithItems) {
                        showSnackBar(
                          'جاري تحميل السلة... حاول بعد لحظات',
                          isError: true,
                        );
                        return;
                      }

                      final alreadyInCart = cartCubit.isInCart(product.name);

                      if (alreadyInCart) {
                        showSnackBar('المنتج موجود بالفعل في السلة');
                      } else {
                        cartCubit.addToCart(userId, product.id, 1);
                        showSnackBar('تمت إضافة المنتج إلى السلة');
                      }
                    },

                    onFavoriteToggle: () async {
                      setState(() {
                        favoriteProducts.removeAt(index);
                      });
                      await CachingUtils.saveFavoriteItems(
                        favoriteProducts.map((e) => e.toJson()).toList(),
                      );
                    },
                  ),
                );
              },
            ),
          ),

          SizedBox(height: 20.h),
          AppButton(
            btnText: 'Add all item to cart',
            width: double.infinity,
            onTap: () {
              final cartCubit = context.read<CartCubit>();
              final userId = CachingUtils.userID;

              // Check if cart is loaded first
              if (cartCubit.state is! CartSuccessWithItems) {
                showSnackBar(
                  'جاري تحميل السلة... حاول مرة أخرى',
                  isError: true,
                );
                return;
              }

              final List<Product> notInCart =
                  favoriteProducts.where((product) {
                    return !cartCubit.isInCart(product.name);
                  }).toList();

              if (notInCart.isEmpty) {
                showSnackBar('كل المنتجات موجودة بالفعل في السلة');
              } else {
                for (final product in notInCart) {
                  cartCubit.addToCart(userId, product.id, 1);
                }

                showSnackBar('تمت إضافة المنتجات الجديدة فقط إلى السلة');
              }
            },
          ),

          SizedBox(height: 16.h),
        ],
      ),
    );
  }
}
