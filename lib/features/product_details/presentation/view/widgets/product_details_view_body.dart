import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:furnitrue_app/core/utils/app_colors/app_colors.dart';
import 'package:furnitrue_app/core/utils/caching_utils/caching_utils.dart';
import 'package:furnitrue_app/core/widgets/custom_text.dart';
import 'package:furnitrue_app/core/widgets/snack_bar.dart';
import 'package:furnitrue_app/features/cart/manger/cart_cubit/cart_cubit.dart';
import 'package:furnitrue_app/features/favorite/manger/cubit/favorite_cubit.dart';
import 'package:furnitrue_app/features/home/data/model/prouduct_response_model.dart';
import 'package:furnitrue_app/features/product_details/presentation/view/widgets/counter_container.dart';
import 'package:furnitrue_app/features/product_details/presentation/view/widgets/product_detailes_container.dart';
import 'package:furnitrue_app/features/product_details/presentation/view/widgets/product_details_image.dart';
import 'package:furnitrue_app/features/product_details/presentation/view/widgets/product_detalis_app_bar.dart';

class ProductDetailsViewBody extends StatefulWidget {
  final Product product;
  const ProductDetailsViewBody({super.key, required this.product});

  @override
  State<ProductDetailsViewBody> createState() => _ProductDetailsViewBodyState();
}

class _ProductDetailsViewBodyState extends State<ProductDetailsViewBody> {
  int quantity = 1;

  void onQuantityChanged(int newQuantity) {
    setState(() {
      quantity = newQuantity;
    });
  }

  @override
  void initState() {
    super.initState();
    // Make sure cart is loaded for isInCart to work
    context.read<CartCubit>().getCartItems();
  }

  @override
  Widget build(BuildContext context) {
    final product = widget.product;
    final userId = CachingUtils.userID;

    return BlocBuilder<CartCubit, CartState>(
      builder: (context, cartState) {
        final cartCubit = context.read<CartCubit>();
        final cartId = cartCubit.getCartIdByProductName(product.name);

        final isInCart = cartCubit.isInCart(
          product.name,
        ); // or product.id if supported

        return Stack(
          children: [
            Column(
              children: [
                /// 🖼️ Product Image Section
                Container(
                  width: double.infinity,
                  color: AppColors.secondaryColor,
                  child: Column(
                    children: [
                      ProductDetailsImage(
                        img:
                            product.images.isNotEmpty
                                ? 'https://zbooma.com/furniture_api/${product.images.first}'
                                : null,
                      ),
                      AppText(
                        title: '360',
                        color: AppColors.primaryColor,
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                      ),
                      SizedBox(height: 3.h),
                      SizedBox(height: 40.h),
                    ],
                  ),
                ),

                /// 📦 Product Details & Cart Button
                Expanded(
                  child: Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(color: Colors.white),
                    child: ProductDetailesContainer(
                      title: product.name,
                      price: (double.parse(product.price) * quantity)
                          .toStringAsFixed(2),
                      description: product.description,
                      isInCart: isInCart,
                      onToggleCart: () async {
                        if (isInCart) {
                          if (cartId != null) {
                            await cartCubit.deleteCartItem(cartId);
                            showSnackBar("تم حذف المنتج من السلة");
                          } else {
                            showSnackBar(
                              "لم يتم العثور على المنتج في السلة",
                              isError: true,
                            );
                          }
                        } else {
                          await cartCubit.addToCart(
                            userId,
                            product.id,
                            quantity,
                          );
                          showSnackBar("تمت إضافة المنتج إلى السلة");
                        }
                        setState(() {});
                      },
                    ),
                  ),
                ),
              ],
            ),

            /// ➕ Quantity Selector
            Positioned(
              top: 0.47.sh + 20.h,
              left: 0,
              right: 0,
              child: Center(
                child: CounterContainer(onQuantityChanged: onQuantityChanged),
              ),
            ),

            /// 🔙 Back AppBar
            const ProductDetalisAppBar(),

            /// ❤️ Favorite Icon
            Positioned(
              top: 20.h,
              right: 5.w,
              child: BlocBuilder<FavoriteCubit, FavoriteState>(
                builder: (context, state) {
                  final favCubit = context.read<FavoriteCubit>();
                  final isFavorite = favCubit.isFavorite(product);

                  return GestureDetector(
                    onTap: () {
                      favCubit.toggleFavorite(product);
                      setState(() {});
                    },
                    child: Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(color: Colors.black12, blurRadius: 4),
                        ],
                      ),
                      child: Icon(
                        isFavorite
                            ? Icons.favorite
                            : Icons.favorite_border_outlined,
                        color: AppColors.primaryColor,
                        size: 24,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
