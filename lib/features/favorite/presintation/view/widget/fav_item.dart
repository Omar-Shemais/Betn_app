import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:furnitrue_app/core/utils/app_colors/app_colors.dart';
import 'package:furnitrue_app/core/widgets/custom_plus_icon.dart';
import 'package:furnitrue_app/core/widgets/custom_text.dart';
import 'package:furnitrue_app/features/cart/manger/cart_cubit/cart_cubit.dart';
import 'package:furnitrue_app/features/favorite/manger/cubit/favorite_cubit.dart';
import 'package:furnitrue_app/features/home/data/model/prouduct_response_model.dart';

class FavoriteProductItem extends StatelessWidget {
  final Product product;
  final VoidCallback? onPlusTap;
  final VoidCallback? onFavoriteToggle;
  final void Function(BuildContext)? onDelete;

  const FavoriteProductItem({
    super.key,
    required this.product,
    this.onPlusTap,
    this.onFavoriteToggle,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final isFavorite = context.watch<FavoriteCubit>().isFavorite(product);

    return Row(
      children: [
        /// Image with Favorite Icon
        Stack(
          children: [
            Container(
              color: AppColors.offWhite,
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8.r),
                  bottomLeft: Radius.circular(8.r),
                ),
                child:
                    product.images.isNotEmpty
                        ? Image.network(
                          'https://zbooma.com/furniture_api/${product.images.first}',
                          width: .4.sw,
                          height: 120.h,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Image.asset(
                              'assets/images/cart_placeholder.png',
                              width: .4.sw,
                              height: 120.h,
                              fit: BoxFit.cover,
                            );
                          },
                        )
                        : Image.asset(
                          'assets/images/cart_placeholder.png',
                          width: .4.sw,
                          height: 120.h,
                          fit: BoxFit.cover,
                        ),
              ),
            ),

            Positioned(
              top: 8,
              left: 8,
              child: GestureDetector(
                onTap: () {
                  context.read<FavoriteCubit>().toggleFavorite(product);
                  onFavoriteToggle?.call();
                },
                child: Icon(
                  isFavorite ? Icons.favorite : Icons.favorite_border_outlined,
                  color: AppColors.primaryColor,
                  size: 22,
                ),
              ),
            ),
          ],
        ),

        /// Info Section
        Expanded(
          child: Container(
            height: 120.h,
            padding: EdgeInsets.only(left: 8.w, right: 16.w, top: 20.h),
            decoration: BoxDecoration(
              color: AppColors.secondaryColor,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(8.r),
                bottomRight: Radius.circular(8.r),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Product Name
                AppText(
                  title: product.name,
                  fontSize: 14,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const Spacer(),

                /// Price + Add Button
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppText(
                      title: '\$${product.price}',
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const Spacer(),

                    BlocBuilder<CartCubit, CartState>(
                      builder: (context, state) {
                        return CustomPlusIcon(onTap: onPlusTap);
                      },
                    ),
                  ],
                ),
                SizedBox(height: 16.h),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
