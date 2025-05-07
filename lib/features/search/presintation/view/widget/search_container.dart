import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:furnitrue_app/core/utils/app_colors/app_colors.dart';
import 'package:furnitrue_app/core/widgets/custom_text.dart';

class SearchContainer extends StatelessWidget {
  const SearchContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 60.w,
          height: 60.h,
          decoration: ShapeDecoration(
            color: AppColors.offWhite,
            shape: OvalBorder(),
            image: DecorationImage(
              image: AssetImage('assets/images/cart_placeholder.png'),
            ),
          ),
        ),
        SizedBox(height: 9.h),
        AppText(title: 'Sofa'),
      ],
    );
  }
}
