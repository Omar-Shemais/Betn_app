// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:furnitrue_app/core/utils/app_colors/app_colors.dart';
import 'package:furnitrue_app/core/utils/route_utils/route_utils.dart';
import 'package:furnitrue_app/core/widgets/custom_plus_icon.dart';
import 'package:furnitrue_app/core/widgets/custom_text.dart';
import 'package:furnitrue_app/features/favorite/manger/cubit/favorite_cubit.dart';
import 'package:furnitrue_app/features/home/data/model/prouduct_response_model.dart';
import 'package:furnitrue_app/features/product_details/presentation/view/product_details_view.dart';

// ignore: must_be_immutable
class ItemCart extends StatefulWidget {
  final Product product;
  void Function()? onPlusTap;

  ItemCart({super.key, required this.product, this.onPlusTap});

  @override
  State<ItemCart> createState() => _ItemCartState();
}

class _ItemCartState extends State<ItemCart> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 127.w,
      height: 204.h,
      child: InkWell(
        onTap: () {
          RouteUtils.push(ProductDetailsView(product: widget.product));
        },
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  color: AppColors.offWhite,
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8.r),
                      topRight: Radius.circular(8.r),
                    ),
                    child:
                        widget.product.images.isNotEmpty
                            ? Image.network(
                              "https://zbooma.com/furniture_api/${widget.product.images.first}",
                              width: 127.w,
                              height: 124.h,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Image.asset(
                                  'assets/images/cart_placeholder.png',
                                  width: 127.w,
                                  height: 124.h,
                                  fit: BoxFit.cover,
                                );
                              },
                            )
                            : Image.asset(
                              'assets/images/cart_placeholder.png',
                              width: 127.w,
                              height: 124.h,
                              fit: BoxFit.cover,
                            ),
                  ),
                ),
                BlocBuilder<FavoriteCubit, FavoriteState>(
                  builder: (context, state) {
                    final cubit = context.read<FavoriteCubit>();
                    final isFav = cubit.isFavorite(widget.product);
                    return Positioned(
                      top: 10.h,
                      right: 10.w,
                      child: InkWell(
                        onTap: () {
                          cubit.toggleFavorite(widget.product);
                          setState(() {});
                        },
                        child: Icon(
                          isFav ? Icons.favorite : Icons.favorite_border,
                          size: 16.sp,
                          color: AppColors.primaryColor,
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),

            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
              height: 80.h,
              decoration: BoxDecoration(
                color: AppColors.secondaryColor,
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(8.r),
                  bottomLeft: Radius.circular(8.r),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(title: widget.product.name),
                  SizedBox(height: 10.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AppText(
                        title: '${widget.product.price} \$',
                        fontSize: 10,
                        color: AppColors.primaryColor,
                        fontWeight: FontWeight.w500,
                      ),
                      CustomPlusIcon(onTap: widget.onPlusTap),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
