import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:furnitrue_app/core/utils/app_colors/app_colors.dart';
import 'package:furnitrue_app/core/widgets/custom_button.dart';
import 'package:furnitrue_app/core/widgets/custom_text.dart';

class ProductDetailesContainer extends StatelessWidget {
  const ProductDetailesContainer({
    super.key,
    required this.title,
    required this.price,
    required this.description,
    required this.isInCart,
    required this.onToggleCart,
  });

  final String title;
  final String price;
  final String description;
  final bool isInCart;
  final VoidCallback onToggleCart;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: .47.sh,
      width: double.infinity,
      decoration: BoxDecoration(color: AppColors.white),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppText(
                  title: title,
                  fontSize: 24.sp,
                  fontWeight: FontWeight.bold,
                ),
                AppText(
                  title: price,
                  fontSize: 24.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryColor,
                ),
              ],
            ),
            SizedBox(height: 20.h),
            AppText(title: 'Details'),
            SizedBox(height: 4.h),
            AppText(
              title: description,
              fontSize: 14.sp,
              color: AppColors.lightTextColor,
            ),
            SizedBox(height: 20.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(3, (index) {
                return Container(
                  width: 60.w,
                  height: 60.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.r),
                    image: const DecorationImage(
                      image: AssetImage('assets/images/chair2.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              }),
            ),
            const Spacer(),

            /// ✅ Button with dynamic label & color
            AppButton(
              btnText: isInCart ? 'الحذف من السله' : 'اضافة الى السلة',
              width: double.infinity,
              btnColor:
                  isInCart ? AppColors.lightTextColor : AppColors.primaryColor,
              textColor: AppColors.white,
              onTap: onToggleCart,
            ),

            SizedBox(height: 30.h),
          ],
        ),
      ),
    );
  }
}
