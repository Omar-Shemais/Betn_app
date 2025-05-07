import 'package:flutter/material.dart';
import 'package:furnitrue_app/core/utils/app_colors/app_colors.dart';
import 'package:furnitrue_app/core/utils/dimensions/dimensions.dart';

class CustomIconContainer extends StatelessWidget {
  const CustomIconContainer({super.key, required this.icon});
  final String icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45.height,
      width: 50.width,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(color: AppColors.lightTextColor, spreadRadius: 0.6),
        ],
      ),
      child: Image.asset(icon),
    );
  }
}
