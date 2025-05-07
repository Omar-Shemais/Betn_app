// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:furnitrue_app/core/utils/app_colors/app_colors.dart';
import 'package:furnitrue_app/core/utils/route_utils/route_utils.dart';
import 'package:furnitrue_app/core/widgets/custom_plus_icon.dart';
import 'package:furnitrue_app/core/widgets/custom_text.dart';
import 'package:furnitrue_app/features/home/data/model/prouduct_response_model.dart';
import 'package:furnitrue_app/features/product_details/presentation/view/product_details_view.dart';

// ignore: must_be_immutable
class ItemCart extends StatelessWidget {
  final Product product;
  void Function()? onPlusTap;

  ItemCart({super.key, required this.product, this.onPlusTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 127.w,
      height: 204.h,
      child: InkWell(
        onTap: () {
          RouteUtils.push(ProductDetailsView(product: product));
        },
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  width: 127.w,
                  height: 124.h,
                  decoration: BoxDecoration(
                    color: AppColors.offWhite,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8),
                    ),
                    image:
                        product.images.isNotEmpty
                            ? DecorationImage(
                              image: NetworkImage(
                                "https://zbooma.com/furniture_api/${product.images.first}",
                              ),
                              fit: BoxFit.cover,
                            )
                            : const DecorationImage(
                              image: AssetImage(
                                'assets/images/cart_placeholder.png',
                              ),
                              fit: BoxFit.cover,
                            ),
                  ),
                ),
                Positioned(
                  top: 10.h,
                  right: 10.w,
                  child: Icon(
                    Icons.favorite_border_outlined,
                    color: AppColors.primaryColor,
                    size: 20.h,
                  ),
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
                  AppText(title: product.name),
                  SizedBox(height: 10.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AppText(
                        title: '${product.price} \$',
                        fontSize: 10,
                        color: AppColors.primaryColor,
                        fontWeight: FontWeight.w500,
                      ),
                      CustomPlusIcon(onTap: onPlusTap),
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
