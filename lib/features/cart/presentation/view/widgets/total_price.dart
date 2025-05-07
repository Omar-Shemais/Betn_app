import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:furnitrue_app/core/utils/app_colors/app_colors.dart';
import 'package:furnitrue_app/core/widgets/custom_text.dart';

class TotalPrice extends StatelessWidget {
  const TotalPrice({
    super.key,
    required this.totalPrice,
    required this.totalItems,
  });

  final String totalPrice, totalItems;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 103.h,
      decoration: ShapeDecoration(
        color: const Color(0xFFF1F4F4),
        shape: RoundedRectangleBorder(
          side: BorderSide(width: 1, color: const Color(0xFF9AADAF)),
          borderRadius: BorderRadius.circular(8.r),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppText(title: 'Total price', fontSize: 20),

                AppText(
                  title: '\$$totalPrice',
                  fontSize: 22,
                  color: AppColors.primaryColor,
                ),
              ],
            ),
            Row(
              children: [
                AppText(
                  title: "$totalItems items",
                  fontSize: 18,
                  color: AppColors.lightGreen,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
