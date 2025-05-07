import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:furnitrue_app/core/utils/app_colors/app_colors.dart';
import 'package:furnitrue_app/core/widgets/custom_text.dart';
import 'package:furnitrue_app/core/widgets/snack_bar.dart';
import 'package:furnitrue_app/features/cart/manger/cart_cubit/cart_cubit.dart';

class CartCounterContainer extends StatelessWidget {
  final int quantity;
  final int cartId;
  final String msg;

  const CartCounterContainer({
    super.key,
    required this.quantity,
    required this.cartId,
    required this.msg,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50.w,
      height: 20.h,
      decoration: ShapeDecoration(
        color: AppColors.lightGreen,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100.r),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          InkWell(
            onTap: () {
              context.read<CartCubit>().updateCartItemQuantity(
                cartId,
                quantity + 1,
              );
              showSnackBar(msg);
            },
            child: Container(
              decoration: ShapeDecoration(
                color: AppColors.secondaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
              ),
              child: Icon(
                Icons.add,
                color: AppColors.primaryColor,
                size: 13.sp,
              ),
            ),
          ),
          AppText(title: '$quantity', color: AppColors.white, fontSize: 14.sp),
          InkWell(
            onTap: () {
              if (quantity > 1) {
                context.read<CartCubit>().updateCartItemQuantity(
                  cartId,
                  quantity - 1,
                );
                showSnackBar(msg);
              }
            },
            child: Container(
              decoration: ShapeDecoration(
                color: AppColors.secondaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
              ),
              child: Icon(
                Icons.remove,
                color: AppColors.primaryColor,
                size: 13.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
