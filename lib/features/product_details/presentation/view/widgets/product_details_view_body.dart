import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:furnitrue_app/core/utils/app_colors/app_colors.dart';
import 'package:furnitrue_app/core/utils/caching_utils/caching_utils.dart';
import 'package:furnitrue_app/core/widgets/custom_text.dart';
import 'package:furnitrue_app/core/widgets/snack_bar.dart';
import 'package:furnitrue_app/features/cart/manger/cart_cubit/cart_cubit.dart';
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
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            Container(
              width: double.infinity,
              color: AppColors.secondaryColor,
              child: Column(
                children: [
                  ProductDetailsImage(
                    img:
                        widget.product.images.isNotEmpty
                            ? 'https://zbooma.com/furniture_api/${widget.product.images.first}'
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
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(color: Colors.white),
                child: ProductDetailesContainer(
                  title: widget.product.name,
                  price: widget.product.price,
                  description: widget.product.description,
                  onTap: () {
                    final userId = CachingUtils.userID;
                    context.read<CartCubit>().addToCart(
                      userId,
                      widget.product.id,
                      quantity,
                    );
                    showSnackBar('تمت إضافة المنتج إلى السلة"');
                  },
                ),
              ),
            ),
          ],
        ),

        Positioned(
          top: 0.47.sh + 20.h,
          left: 0,
          right: 0,
          child: Center(
            child: CounterContainer(onQuantityChanged: onQuantityChanged),
          ),
        ),

        const ProductDetalisAppBar(),
      ],
    );
  }
}
