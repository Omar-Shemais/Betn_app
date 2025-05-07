import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:furnitrue_app/core/utils/app_colors/app_colors.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';

class ProductDetailsImage extends StatelessWidget {
  const ProductDetailsImage({super.key, String? img});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Container(
          width: 215.w,
          height: 80.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.elliptical(215 / 2, 80 / 2)),
            border: GradientBoxBorder(
              width: 1.5,
              gradient: LinearGradient(
                colors: [AppColors.primaryColor, AppColors.secondaryColor],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              ),
            ),
          ),
        ),
        Container(
          width: 30.w,
          height: 15.h,
          alignment: Alignment.bottomCenter,
          decoration: ShapeDecoration(
            color: AppColors.secondaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.horizontal(),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset('assets/icons/back_arrow.svg', width: 3.w),
              SizedBox(width: 4.w),
              SvgPicture.asset('assets/icons/front_arrow.svg', width: 3.w),
            ],
          ),
        ),
        Image.asset(
          'assets/images/chair2.png',
          width: 163.w,
          height: 367.h,
          fit: BoxFit.cover,
        ),
        SizedBox(height: 30.h),
      ],
    );
  }
}
