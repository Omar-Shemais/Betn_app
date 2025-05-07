import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:furnitrue_app/core/utils/app_colors/app_colors.dart';
import 'package:furnitrue_app/core/widgets/custom_text.dart';

class CategoryButton extends StatelessWidget {
  final String name;
  final bool isSelected;
  final VoidCallback onTap;

  const CategoryButton({
    super.key,
    required this.name,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primaryColor : AppColors.secondaryColor,
          borderRadius: BorderRadius.circular(100.r),
          border: Border.all(color: const Color(0xFF9AADAF), width: 1.w),
        ),
        child: AppText(
          title: name,

          color: isSelected ? AppColors.secondaryColor : AppColors.primaryColor,
        ),
      ),
    );
  }
}
