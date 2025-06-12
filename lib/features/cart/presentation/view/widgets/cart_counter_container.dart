import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:furnitrue_app/core/utils/app_colors/app_colors.dart';
import 'package:furnitrue_app/core/widgets/custom_text.dart';
import 'package:furnitrue_app/core/widgets/snack_bar.dart';
import 'package:furnitrue_app/features/cart/manger/cart_cubit/cart_cubit.dart';

class CartCounterContainer extends StatefulWidget {
  final int initialQuantity;
  final int cartId;

  const CartCounterContainer({
    super.key,
    required this.initialQuantity,
    required this.cartId,
  });

  @override
  State<CartCounterContainer> createState() => _CartCounterContainerState();
}

class _CartCounterContainerState extends State<CartCounterContainer> {
  late int quantity;

  @override
  void initState() {
    super.initState();
    quantity = widget.initialQuantity;
  }

  void _updateQuantity(int newQuantity) {
    setState(() {
      quantity = newQuantity;
    });
    context.read<CartCubit>().updateCartItemQuantity(widget.cartId, quantity);
  }

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
            onTap: () => _updateQuantity(quantity + 1),
            child: _circleIcon(Icons.add),
          ),
          AppText(title: '$quantity', color: AppColors.white, fontSize: 11.sp),
          InkWell(
            onTap: () {
              if (quantity > 1) {
                _updateQuantity(quantity - 1);
              }
            },
            child: _circleIcon(Icons.remove),
          ),
        ],
      ),
    );
  }

  Widget _circleIcon(IconData icon) {
    return Container(
      decoration: ShapeDecoration(
        color: AppColors.secondaryColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
      ),
      child: Icon(icon, color: AppColors.primaryColor, size: 13.sp),
    );
  }
}
